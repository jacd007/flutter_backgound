import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config/config_m.dart';
import '../../features/features_m.dart';
import '../core_m.dart';

class RouterController extends GetxController {
  // bool to exit app
  var canPop = false.obs;

  // ========  Settings Home Main Page ========

  /// [selectedHomeIndex] index position from screen
  var selectedHomeIndex = 0.obs;

  /// [listViewHomeIndex] list memory from index position screens
  var listViewHomeIndex = <int>[0].obs;

  /// list widgets from `HomeMainPage`
  /// 0  =>  Home Screen
  /// 1  =>  Null
  /// 2  =>  Null
  /// 3  =>  Null
  /// 4  =>  Null
  List<Widget> get screenHome => [
    const HomeScreen(), // 1
    const Center(child: Text('Home 2')), // const DraggableScreen(), // 0
    const Center(child: Text('Home 3')), //  2
    const Center(child: Text('Home 4')), // 3
    const Center(child: Text('Home 5')), // 4
  ];

  // *************************************************

  // *************************************************

  ///
  Future<bool> onWillPop(_, _) async {
    if (listViewHomeIndex.length <= 1) return onWillPopExit();

    onBackIndex();

    return Future.value(false);
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPopExit() {
    canPop.value = true;
    DateTime now = DateTime.now();

    final val1 = currentBackPressTime == null;
    final val2 = now.difference(currentBackPressTime ?? now);
    const def = Duration(milliseconds: 1300);

    if (val1 || val2 > def) {
      currentBackPressTime = now;

      Get.snackbar(
        Tk.toastTitleExit.tr,
        Tk.toastMsgExit.tr,
        duration: def,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.grey.shade900,
      );

      return Future.value(false);
    }
    return Future.value(true);
  }

  /// [onItemTapped] change the index in the controller to change screen in the
  /// widgets list "screen".
  void onItemTapped(int index) {
    canPop.value = false;
    listViewHomeIndex.add(index);

    selectedHomeIndex.value = index;

    update();
  }

  void onBackIndex() {
    if (listViewHomeIndex.length > 1) {
      listViewHomeIndex.removeLast();
      selectedHomeIndex.value = listViewHomeIndex.last;
      canPop.value = false;
      update();
    }
  }

  /// replace screen un homeMain
  // Widget get screenHomeChange {
  //   return screenHome.elementAt(selectedHomeIndex.value);
  // }

  // *************************************************

  // *************************************************

  Future<void> onGoHome() async {
    Get.offAndToNamed(AppRoutes.home);
    update();
  }

  // *************************************************
  // *************************************************
}
