import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reslink_test/constants/colors.dart';

import '../../home/ui/home_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

final PageController pageController = PageController(
    keepPage: true
);

class _NavBarState extends State<NavBar> {

  List<int> tabIndex = [0,1,2];

  @override
  Widget build(BuildContext context) {

    List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          backgroundColor: Colors.orange,
          icon: Transform.scale(
            scale: 1.05,
            child: Icon(
              CupertinoIcons.house, // Changed to Cupertino home icon
              color: Colors.black38,
            ),
          ),
          label: 'Devices',
          activeIcon: Transform.scale(
              scale: 1.15,
              child: Icon(
                CupertinoIcons.house_fill,
                color: secondaryBlueColor,
              ))),
      BottomNavigationBarItem(
          backgroundColor: Colors.orange,
          icon: Icon(
            Icons.explore,
            color: primaryGreyColor,
          ), // Changed to Cupertino grid icon
          label: 'Explore',
          activeIcon: Icon(
            Icons.explore,
            color: secondaryBlueColor,
          )),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.person, // Changed to Cupertino person icon
            color: primaryGreyColor,
          ),
          label: 'Profile',
          activeIcon: Icon(
            CupertinoIcons.person_fill,
            color: secondaryBlueColor,
          )),
    ];
    List<Widget> bottomNavScreen = <Widget>[
      const HomePage(),
      const HomePage(),
      const HomePage(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
        },
        children: bottomNavScreen,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        // margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: getScreenHeight(context) * 0.02),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: bottomNavItems,
            currentIndex: tabIndex[0],
            selectedItemColor: secondaryBlueColor,
            // unselectedItemColor: Colors.white,
            elevation: 10,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: primaryGreyColor,
            onTap: (index) {
              pageController.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }
}
