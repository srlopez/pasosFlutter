// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorito_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritoAdapter extends TypeAdapter<Favorito> {
  @override
  final int typeId = 0;

  @override
  Favorito read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorito(
      nombre: fields[0] as String,
      id: fields[1] as String,
    )..puntos = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, Favorito obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.puntos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
