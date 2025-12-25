import 'package:code_note/core/controllers/note_controller.dart';
import 'package:code_note/core/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final categoryControllerProvider = StateNotifierProvider<CategoryController, List<NoteCategoryModel>>(
  (ref) => CategoryController(),
);

final categoryNoteCountProvider = Provider.family<int, int>((ref, categoryId) {
  final notesAsync = ref.watch(notesControllerProvider);

  return notesAsync.when(
    data: (notes) =>
        notes.where((note) => note.categoryId == categoryId).length,
    loading: () => 0,
    error: (_, _) => 0,
  );
});
class CategoryController extends StateNotifier<List<NoteCategoryModel>> {
  CategoryController() : super(_defaultCategories);

  static final List<NoteCategoryModel> _defaultCategories = [
    NoteCategoryModel(
      id: 1,
      name: 'کد نویسی',
      icon: Icons.code,
      noteCount: 103
    ),
    NoteCategoryModel(
      id: 2,
      name: 'شخصی',
      icon: CupertinoIcons.person,
      noteCount: 1073
    ),
    NoteCategoryModel(
      id: 3,
      name: 'ایده‌ها',
      icon: Icons.light,
      noteCount: 39
    ),
    NoteCategoryModel(
      id: 4,
      name: 'مطالعه',
      icon: CupertinoIcons.book,
      noteCount: 356
    ),
  ];

  // category management methods -> next updates
  void addCategory(NoteCategoryModel category) {
    state = [...state, category];
  }

  void updateCategory(int id, NoteCategoryModel updatedCategory) {
    state = state.map((category) => 
      category.id == id ? updatedCategory : category
    ).toList();
  }

  void deleteCategory(int id) {
    state = state.where((category) => category.id != id).toList();
  }

  NoteCategoryModel? getCategoryById(int id) {
    try {
      return state.firstWhere((category) => category.id == id);
    } catch (_) {
      return null;
    }
  }
}