import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/screens/QR_screen/body.dart';
import 'package:vtms_v6/screens/settings_screen/settings.dart';
import 'package:vtms_v6/screens/start_screen/start.dart';

class MainFrame extends StatefulWidget {

  @override
  _MainFrameState createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {
  int _curIndex = 0; // Current Index of Nav Icon Pressed
  final _pageController = PageController();
  List<Widget> _screens = [ Start(), PreQR(), Settings() ];

  void _onPageChanged(int index) {}
  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[900],
          selectedFontSize: 14,
          unselectedFontSize: 13,
          iconSize: 32,
          unselectedItemColor: fullWhite,

          currentIndex: _curIndex,
          onTap: (index){
            setState(() {
              _curIndex = index;
              _onItemTapped(_curIndex);
          } );  },
          items: [
            BottomNavigationBarItem(label: 'Home',
              icon: Icon(Icons.home, color: _curIndex == 0 ? fullRed : unselIcon)),
            BottomNavigationBarItem(label: 'Capture',
              icon: Icon(Icons.camera, color: _curIndex == 1 ? fullRed : unselIcon)),
            BottomNavigationBarItem(label: 'Settings',
              icon: Icon(Icons.settings, color: _curIndex == 2 ? fullRed : unselIcon)),
          ],
        ),
      ),
    );
  }
}