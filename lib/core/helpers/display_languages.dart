import 'package:code_note/core/models/hive/note_model.dart';

extension NoteLanguageExtension on NoteLanguage {
  String get displayName {
    switch (this) {
      case NoteLanguage.dart:
        return 'Dart';
      case NoteLanguage.javascript:
        return 'JavaScript';
      case NoteLanguage.python:
        return 'Python';
      case NoteLanguage.java:
        return 'Java';
      case NoteLanguage.cpp:
        return 'C++';
      case NoteLanguage.swift:
        return 'Swift';
      case NoteLanguage.kotlin:
        return 'Kotlin';
      case NoteLanguage.php:
        return 'PHP';
      case NoteLanguage.ruby:
        return 'Ruby';
      case NoteLanguage.go:
        return 'Go';
      case NoteLanguage.rust:
        return 'Rust';
      case NoteLanguage.sql:
        return 'SQL';
      case NoteLanguage.html:
        return 'HTML';
      case NoteLanguage.css:
        return 'CSS';
      case NoteLanguage.markdown:
        return 'Markdown';
      case NoteLanguage.plainText:
        return 'Plain Text';
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
      case NoteLanguage.markdown:
        return '.md';
      case NoteLanguage.plainText:
        return '.txt';
    }
  }
}