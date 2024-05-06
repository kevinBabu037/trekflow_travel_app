// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminModelAdapter extends TypeAdapter<AdminModel> {
  @override
  final int typeId = 1;

  @override
  AdminModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminModel(
      imgUrl: fields[0] as String,
      placeName: fields[1] as String,
      location: fields[2] as String,
      discription: fields[3] as String,
      imgUrl1: fields[4] as String,
      imgUrl2: fields[5] as String,
      imgUrl3: fields[6] as String,
      catagorys: fields[7] as String?,
      placeKey: fields[9] as String,
      review: (fields[8] as List?)?.cast<String>(),
      userId: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.imgUrl)
      ..writeByte(1)
      ..write(obj.placeName)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.discription)
      ..writeByte(4)
      ..write(obj.imgUrl1)
      ..writeByte(5)
      ..write(obj.imgUrl2)
      ..writeByte(6)
      ..write(obj.imgUrl3)
      ..writeByte(7)
      ..write(obj.catagorys)
      ..writeByte(8)
      ..write(obj.review)
      ..writeByte(9)
      ..write(obj.placeKey)
      ..writeByte(10)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
