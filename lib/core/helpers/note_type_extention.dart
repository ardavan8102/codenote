import 'package:code_note/core/models/hive/note_model.dart';
import 'package:flutter/material.dart';

extension NoteTypeExtension on NoteType {
  IconData get icon {
    switch (this) {
      case NoteType.note:
        return Icons.description;
      case NoteType.bug:
        return Icons.bug_report;
      case NoteType.task:
        return Icons.task_alt;
      case NoteType.idea:
        return Icons.lightbulb_outline;
      case NoteType.snippet:
        return Icons.code;
      case NoteType.personal:
        return Icons.person;
    }
  }

  String get label {
    switch (this) {
      case NoteType.note:
        return 'یادداشت';
      case NoteType.bug:
        return 'باگ و بوگ';
      case NoteType.task:
        return 'تسک';
      case NoteType.idea:
        return 'ایده';
      case NoteType.snippet:
        return 'قطعه کد';
      case NoteType.personal:
        return 'شخصی';
    }
  }
}