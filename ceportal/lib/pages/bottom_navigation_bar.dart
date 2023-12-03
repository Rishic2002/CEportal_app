import 'package:ceportal/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

import 'notification_screen.dart';
import 'settings_page.dart';
import 'user_screen.dart';

class NavBottom extends StatefulWidget {
  final String userId;
  const NavBottom({super.key, required this.userId});

  @override
  _NavBottomState createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  final Color navigationBarColor = const Color.fromARGB(255, 192, 238, 242);
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                const home_page(),
                NotificationPage(),
                UserPage(userId: widget.userId),
                const SettingsPage(),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              top: MediaQuery.of(context).size.height / 1.355,
              child: FloatingNavbar(
                backgroundColor: const Color.fromARGB(255, 208, 217, 219),
                onTap: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  pageController.animateToPage(
                    selectedIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuad,
                  );
                },
                currentIndex: selectedIndex,
                items: <FloatingNavbarItem>[
                  FloatingNavbarItem(icon: Icons.house),
                  FloatingNavbarItem(icon: Icons.book),
                  FloatingNavbarItem(icon: Icons.notification_add),
                  FloatingNavbarItem(icon: Icons.person_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
