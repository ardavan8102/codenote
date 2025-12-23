import 'package:code_note/const/colors.dart';
import 'package:code_note/const/dimens.dart';
import 'package:code_note/core/controllers/page_handler_controller.dart';
import 'package:code_note/gen/assets.gen.dart';
import 'package:code_note/presentation/view/add_new_note.dart';
import 'package:code_note/presentation/view/home_screen.dart';
import 'package:code_note/presentation/view/ideas_page.dart';
import 'package:code_note/presentation/view/notes_page.dart';
import 'package:code_note/presentation/view/settings_page.dart';
import 'package:code_note/presentation/widgets/bottom_nav_icon_button.dart';
import 'package:code_note/presentation/widgets/bottom_nav_icon_rows.dart';
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

    final mainPadding = Dimens.mainScaffoldPadding(context);

    return Scaffold(
      backgroundColor: AppSolidColors.scaffoldBackground,
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
              Positioned(
                bottom: mainPadding,
                right: mainPadding,
                left: mainPadding,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: .center,
                  children: [

                    // background
                    Container(
                      width: size.width,
                      height: size.height * .1,
                      decoration: BoxDecoration(
                        color: AppSolidColors.bottomNavigationBarBackground,
                        borderRadius: .circular(16),
                      ),
                    ),

                    // Left icons
                    BottomNavigationBarIconRows(
                      currentPageIndex: currentPageIndex,
                      ref: ref,
                      isLeft: true,
                      widgets: [
                        BottomNavigationIconButton(
                          currentPageIndex: currentPageIndex,
                          getToPageIndex: 4,
                          imgAsset: Assets.svg.settings,
                          ref: ref,
                        ),
                    
                        BottomNavigationIconButton(
                          currentPageIndex: currentPageIndex,
                          getToPageIndex: 3,
                          imgAsset: Assets.svg.ideas,
                          ref: ref,
                        ),
                      ],
                    ),


                    // right Icons
                    BottomNavigationBarIconRows(
                      currentPageIndex: currentPageIndex,
                      ref: ref,
                      isLeft: false,
                      widgets: [
                          BottomNavigationIconButton(
                            currentPageIndex: currentPageIndex,
                            getToPageIndex: 1,
                            imgAsset: Assets.svg.notes,
                            ref: ref,
                          ),
                      
                          BottomNavigationIconButton(
                            currentPageIndex: currentPageIndex,
                            getToPageIndex: 0,
                            imgAsset: Assets.svg.home,
                            ref: ref,
                          ),
                        ],
                    ),


                    // add button
                    Positioned(
                      top: -(size.height * .1) / 2.5,
                      child: Container(
                        height: size.height * .08,
                        width: size.height * .08,
                        decoration: BoxDecoration(
                          color: AppSolidColors.primary,
                          borderRadius: .circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppSolidColors.primary.withValues(alpha: .4),
                              blurRadius: 40,
                              spreadRadius: 2,
                              offset: Offset(0, 12)
                            ),

                            BoxShadow(
                              color: AppSolidColors.primary.withValues(alpha: .3),
                              blurRadius: 40,
                              spreadRadius: 2,
                              offset: Offset(20, 0)
                            ),

                            BoxShadow(
                              color: AppSolidColors.primary.withValues(alpha: .3),
                              blurRadius: 40,
                              spreadRadius: 2,
                              offset: Offset(-20, 0)
                            ),
                          ]
                        ),
                        child: Icon(Icons.add, size: 40, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}