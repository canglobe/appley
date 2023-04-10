// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactsAdapter extends TypeAdapter<Contacts> {
  @override
  final int typeId = 0;

  @override
  Contacts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contacts(
      imagepath: fields[0] as String,
      name: fields[1] as String,
      number: fields[2] as int,
      relative: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Contacts obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imagepath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.relative);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
