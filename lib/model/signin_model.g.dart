// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignInModelAdapter extends TypeAdapter<SignInModel> {
  @override
  final int typeId = 0;

  @override
  SignInModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignInModel(
      userName: fields[0] as String?,
      emailId: fields[1] as String?,
      password: fields[2] as String?,
      userId: fields[3] as String?,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SignInModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.emailId)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
