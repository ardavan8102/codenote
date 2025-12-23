import 'package:flutter_riverpod/flutter_riverpod.dart';


final pageHandlerControllerProvider = NotifierProvider<PageHandlerController, int>(PageHandlerController.new);

class PageHandlerController extends Notifier<int> {

  @override
  int build() => 0;


  void changePage(int index) {
    state = index;
  }

}