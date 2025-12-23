import 'package:flutter/material.dart';

class NoteCategoryModel {

  int id;
  String name;
  IconData icon;
  int noteCount;

  NoteCategoryModel({
    required this.icon,
    required this.id,
    required this.name,
    required this.noteCount,
  });

}