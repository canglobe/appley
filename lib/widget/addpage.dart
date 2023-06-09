// ignore_for_file: prefer_const_constructors

import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:appley/boxes.dart';
import 'package:appley/model/contacts.dart';

//------------------------------------------------------------------------------//
class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final namecontroller = TextEditingController();
  final numbercontroller = TextEditingController();

  Io.File? image;
  @override
  Widget build(BuildContext context) {
    var device_height = MediaQuery.of(context).size.height;
    var device_Widget = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              image != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                      ),
                      child: Image.file(Io.File(image!.path)),
                    )
                  : SizedBox(
                      height: device_height / 3,
                      child: Icon(
                        CupertinoIcons.person_alt,
                        size: 270,
                      ),
                    ),
              //--------------------------------------------------------------
              Divider(),
              Column(
                children: [
                  CupertinoButton.filled(
                      child: Text("GALLERY"),
                      onPressed: () {
                        pickImage();
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  CupertinoButton.filled(
                      child: Text("CAMERA "),
                      onPressed: () {
                        // pickImage();
                        pickCamera();
                      }),
                ],
              ),
              SizedBox(
                height: 23,
              ),
              //--------------------------------------------------------------
              Divider(),
              Padding(
                padding: const EdgeInsets.all(9),
                child: CupertinoTextField(
                  prefix: Text(" Name    "),
                  controller: namecontroller,
                  placeholder: "Enter Name Here",
                  keyboardType: TextInputType.name,
                ),
              ),

              //------------------------------------------------------------

              Padding(
                padding: const EdgeInsets.all(9),
                child: CupertinoTextField(
                  prefix: Text(" Mobile  "),
                  controller: numbercontroller,
                  placeholder: "Enter Mobile Number Here",
                  keyboardType: TextInputType.phone,
                ),
              ),
              Divider(),
              //-----------------------------------------------------------

              SizedBox(
                height: 25,
              ),
              //---------------------------------------------------------------

              CupertinoButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.add,
                      ),
                      Text(" ADD CONTACT"),
                    ],
                  ),
                  onPressed: () {
                    _copyImage(namecontroller.text.trim());
                    addContact(
                      image!.path,
                      namecontroller.text.trim(),
                      int.parse(numbercontroller.text.trim()),
                    );
                    popout();
                  }),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Pick the Image from Local Storage in Device
  Future pickImage() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;

      final imageTemp = Io.File(img.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Pick the Image From Device Camera
  Future pickCamera() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.camera);
      if (img == null) return;

      final imageTemp = Io.File(img.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Copy image for resize
  Future<void> _copyImage(name) async {
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/$name.jpg';
    final resizedImage = await _resizeImage(image!, 360, 360);
    final newImage = await resizedImage.copy(imagePath);
    setState(() {
      image = newImage;
    });
  }

  // This is Image Resize Class
  Future<Io.File> _resizeImage(Io.File file, int width, int height) async {
    final imageBytes = await file.readAsBytes();
    final originalImage = img.decodeImage(imageBytes);
    final resizedImage =
        img.copyResize(originalImage!, width: width, height: height);
    final directory = await getTemporaryDirectory();
    final targetPath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final resizedFile = Io.File(targetPath)
      ..writeAsBytesSync(img.encodeJpg(resizedImage));
    return resizedFile;
  }

  // Add the Contact in Hive Object
  addContact(
    String imagepath,
    String name,
    int phonenumber,
  ) {
    final contacts = Contacts(
      imagepath: imagepath,
      name: name,
      number: phonenumber,
    );

    final box = Boxes.getContacts();
    box.add(contacts);
  }

  // Finally Add the Contact Popout To Homescreen
  popout() {
    Navigator.pop(context);
  }
}
