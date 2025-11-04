import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/core_m.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  final RouterController routerCtr = Get.find();

  @override
  Widget build(BuildContext context) {
    AppColors.isMode(context);
    return Obx(() {
      return PopScope(
        onPopInvokedWithResult: routerCtr.onWillPop,
        canPop: routerCtr.canPop.value,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: AppColors.primaryBackground,
            body: ResponsiveWidget(
              mobileScreen: SafeArea(
                child: routerCtr.screenHome[routerCtr.selectedHomeIndex.value],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: routerCtr.selectedHomeIndex.value,
              selectedItemColor: AppColors.primary,
              showUnselectedLabels: false,
              onTap: routerCtr.onItemTapped,
              items: List.generate(1, (i) => _bottomNavBarItem(i)),
            ),
          ),
        ),
      );
    });
  }

  BottomNavigationBarItem _bottomNavBarItem([int index = 0]) {
    final selected = routerCtr.selectedHomeIndex.value == index;
    final color = selected ? AppColors.primary : Colors.grey;

    final icons = [
      Assets.menu1,
      Assets.menu2,
      Assets.menu3,
      Assets.menu4,
      Assets.menu5,
    ];

    final labels = [
      Tk.tMenu1.tr,
      Tk.tMenu2.tr,
      Tk.tMenu3.tr,
      Tk.tMenu4.tr,
      Tk.tMenu5.tr,
    ];

    return BottomNavigationBarItem(
      icon: Image.asset(icons[index], width: 20, height: 20, color: color),
      label: labels[index],
    );
  }
}
