import 'package:code_note/const/colors.dart';
import 'package:code_note/core/controllers/page_handler_controller.dart';
import 'package:code_note/presentation/view/navigation_pages/add_new_note.dart';
import 'package:code_note/presentation/view/navigation_pages/home_screen.dart';
import 'package:code_note/presentation/view/navigation_pages/ideas_page.dart';
import 'package:code_note/presentation/view/navigation_pages/notes_page.dart';
import 'package:code_note/presentation/view/navigation_pages/settings_page.dart';
import 'package:code_note/presentation/widgets/bottom_nav/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageHandlerScreen extends ConsumerWidget {
  const PageHandlerScreen({super.key});


  static const List<Widget> _pages = [

    HomeScreen(),

    NotesPage(),

    AddNewNotePage(),

    IdeasPage(),

    SettingsPage(),

  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentPageIndex = ref.watch(pageHandlerControllerProvider);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppSolidColors.scaffoldBackground,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: .topCenter,
            children: [

              // content & pages
              IndexedStack(
                index: currentPageIndex,
                children: _pages,
              ),

              // bottom navbar
              CustomBottomNavigationBar(currentPageIndex: currentPageIndex, ref: ref)
            ],
          ),
        )
      ),
    );
  }
}