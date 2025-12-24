import 'package:code_note/core/models/hive/note_model.dart';
import 'package:code_note/gen/assets.gen.dart';

extension NoteLanguageExtension on NoteLanguage {
  String get displayImage {
    switch (this) {
      case NoteLanguage.dart:
        return Assets.language.dart;
      case NoteLanguage.javascript:
        return Assets.language.js;
      case NoteLanguage.python:
        return Assets.language.python;
      case NoteLanguage.java:
        return Assets.language.java;
      case NoteLanguage.cpp:
        return Assets.language.cpp;
      case NoteLanguage.swift:
        return Assets.language.swift;
      case NoteLanguage.kotlin:
        return Assets.language.kotlin;
      case NoteLanguage.php:
        return Assets.language.php;
      case NoteLanguage.ruby:
        return Assets.language.ruby;
      case NoteLanguage.go:
        return Assets.language.go;
      case NoteLanguage.rust:
        return Assets.language.rust;
      case NoteLanguage.sql:
        return Assets.language.sql;
      case NoteLanguage.html:
        return Assets.language.html;
      case NoteLanguage.css:
        return Assets.language.css;
      case NoteLanguage.plainText:
        return Assets.language.text;
    }
  }

  String get displayName {
    switch (this) {
      case NoteLanguage.dart:
        return 'دارت';
      case NoteLanguage.javascript:
        return 'جاوا اسکریپت';
      case NoteLanguage.python:
        return 'پایتون';
      case NoteLanguage.java:
        return 'جاوا';
      case NoteLanguage.cpp:
        return 'سی پلاس پلاس';
      case NoteLanguage.swift:
        return 'سوییفت';
      case NoteLanguage.kotlin:
        return 'کاتلین';
      case NoteLanguage.php:
        return 'پی اچ پی';
      case NoteLanguage.ruby:
        return 'روبی';
      case NoteLanguage.go:
        return 'گو';
      case NoteLanguage.rust:
        return 'راست';
      case NoteLanguage.sql:
        return 'اس کیو ال';
      case NoteLanguage.html:
        return 'اچ تی ام ال';
      case NoteLanguage.css:
        return 'سی اس اس';
      case NoteLanguage.plainText:
        return 'یادداشت معمولی';
    }
  }
  
  String get fileExtension {
    switch (this) {
      case NoteLanguage.dart:
        return '.dart';
      case NoteLanguage.javascript:
        return '.js';
      case NoteLanguage.python:
        return '.py';
      case NoteLanguage.java:
        return '.java';
      case NoteLanguage.cpp:
        return '.cpp';
      case NoteLanguage.swift:
        return '.swift';
      case NoteLanguage.kotlin:
        return '.kt';
      case NoteLanguage.php:
        return '.php';
      case NoteLanguage.ruby:
        return '.rb';
      case NoteLanguage.go:
        return '.go';
      case NoteLanguage.rust:
        return '.rs';
      case NoteLanguage.sql:
        return '.sql';
      case NoteLanguage.html:
        return '.html';
      case NoteLanguage.css:
        return '.css';
      case NoteLanguage.plainText:
        return '.txt';
    }
  }
}