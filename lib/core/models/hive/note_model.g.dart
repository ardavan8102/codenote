// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 1;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      codeContent: fields[11] as String,
      type: fields[3] as int,
      categoryId: fields[4] as int,
      tags: (fields[5] as List).cast<String>(),
      isPinned: fields[6] as bool,
      isArchived: fields[7] as bool,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      language: fields[10] as NoteLanguage,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.isPinned)
      ..writeByte(7)
      ..write(obj.isArchived)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.language)
      ..writeByte(11)
      ..write(obj.codeContent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteLanguageAdapter extends TypeAdapter<NoteLanguage> {
  @override
  final int typeId = 0;

  @override
  NoteLanguage read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteLanguage.dart;
      case 1:
        return NoteLanguage.javascript;
      case 2:
        return NoteLanguage.python;
      case 3:
        return NoteLanguage.java;
      case 4:
        return NoteLanguage.cpp;
      case 5:
        return NoteLanguage.swift;
      case 6:
        return NoteLanguage.kotlin;
      case 7:
        return NoteLanguage.php;
      case 8:
        return NoteLanguage.ruby;
      case 9:
        return NoteLanguage.go;
      case 10:
        return NoteLanguage.rust;
      case 11:
        return NoteLanguage.sql;
      case 12:
        return NoteLanguage.html;
      case 13:
        return NoteLanguage.css;
      case 14:
        return NoteLanguage.plainText;
      default:
        return NoteLanguage.dart;
    }
  }

  @override
  void write(BinaryWriter writer, NoteLanguage obj) {
    switch (obj) {
      case NoteLanguage.dart:
        writer.writeByte(0);
        break;
      case NoteLanguage.javascript:
        writer.writeByte(1);
        break;
      case NoteLanguage.python:
        writer.writeByte(2);
        break;
      case NoteLanguage.java:
        writer.writeByte(3);
        break;
      case NoteLanguage.cpp:
        writer.writeByte(4);
        break;
      case NoteLanguage.swift:
        writer.writeByte(5);
        break;
      case NoteLanguage.kotlin:
        writer.writeByte(6);
        break;
      case NoteLanguage.php:
        writer.writeByte(7);
        break;
      case NoteLanguage.ruby:
        writer.writeByte(8);
        break;
      case NoteLanguage.go:
        writer.writeByte(9);
        break;
      case NoteLanguage.rust:
        writer.writeByte(10);
        break;
      case NoteLanguage.sql:
        writer.writeByte(11);
        break;
      case NoteLanguage.html:
        writer.writeByte(12);
        break;
      case NoteLanguage.css:
        writer.writeByte(13);
        break;
      case NoteLanguage.plainText:
        writer.writeByte(14);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteLanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
