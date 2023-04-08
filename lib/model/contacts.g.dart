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
    return Contacts()
      ..image_path = fields[0] as String
      ..name = fields[1] as String
      ..phone_number = fields[2] as int
      ..relationship = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Contacts obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.image_path)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone_number)
      ..writeByte(3)
      ..write(obj.relationship);
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
