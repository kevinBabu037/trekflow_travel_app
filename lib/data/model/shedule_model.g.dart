// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shedule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SheduleTripModeAdapter extends TypeAdapter<SheduleTripMode> {
  @override
  final int typeId = 2;

  @override
  SheduleTripMode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SheduleTripMode(
      dataKey: fields[6] as String?,
      userId: fields[5] as String?,
      destination: fields[0] as String,
      startingDate: fields[1] as String,
      endingDate: fields[2] as String,
      companion: (fields[3] as List).cast<String>(),
      budget: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SheduleTripMode obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.destination)
      ..writeByte(1)
      ..write(obj.startingDate)
      ..writeByte(2)
      ..write(obj.endingDate)
      ..writeByte(3)
      ..write(obj.companion)
      ..writeByte(4)
      ..write(obj.budget)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.dataKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SheduleTripModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
