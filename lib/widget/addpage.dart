// ignore_for_file: prefer_const_constructors

import 'dart:io' as Io;

import 'package:appley/boxes.dart';
import 'package:appley/model/contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';

import 'package:image/image.dart' as img;
import 'package:hive/hive.dart';

// import 'package:image/image.dart' as IM;

class Add_Newone extends StatefulWidget {
  const Add_Newone({super.key});

  @override
  State<Add_Newone> createState() => _Add_NewoneState();
}

class _Add_NewoneState extends State<Add_Newone> {
  final namecontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final relationcontroller = TextEditingController();

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
                        Icons.person,
                        size: 300,
                      ),
                    ),
              //--------------------------------------------------------------
              Column(
                children: [
                  CupertinoButton.filled(
                      child: Text("Select photo"),
                      onPressed: () {
                        pickImage();
                      }),
                  CupertinoButton.filled(
                      child: Text("Select photo"),
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
              Divider(),

              Padding(
                padding: const EdgeInsets.all(9),
                child: CupertinoTextField(
                  prefix: Text(" Mobile  "),
                  controller: numbercontroller,
                  placeholder: "Enter Mobile Number Here",
                  keyboardType: TextInputType.phone,
                ),
              ),

              //-----------------------------------------------------------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("  Enter Relationship Here"),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: CupertinoTextField(
                      prefix: Text(" Relation"),
                      controller: relationcontroller,
                      placeholder: "Enter Relationship Here",
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 25,
              ),

              CupertinoButton(
                  child: Text("ADD CONTACT"),
                  onPressed: () {
                    _copyImage(namecontroller.text.trim());
                    addcontact(
                        image!.path,
                        namecontroller.text.trim(),
                        int.parse(numbercontroller.text.trim()),
                        relationcontroller.text.trim());
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

  Future<void> _copyImage(name) async {
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/$name.jpg';
    final resizedImage = await _resizeImage(image!, 360, 360);
    final newImage = await resizedImage.copy(imagePath);
    setState(() {
      image = newImage;
    });
  }

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

  addcontact(String imagepath, String name, int phonenumber, String relation) {
    final contacts = Contacts(
      imagepath: imagepath,
      name: name,
      number: phonenumber,
      relative: relation,
    );

    final box = Boxes.getContacts();
    box.add(contacts);
  }

  popout() {
    Navigator.pop(context);
  }
}
