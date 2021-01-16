
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Bottom_Homepage/bottom_follow.dart';
import 'Bottom_Homepage/bottom_notification.dart';
import 'Bottom_Homepage/bottom_profile.dart';
import 'Bottom_Homepage/bottom_search.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
{

  PageController _pageController = PageController();
  List<Widget> _screen = [
    BottomSearch(),
    BottomNotification(),
    BottomFollow(),
    BottomProfile(),
  ];

  int _selectedIndex = 0;
  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: _screen,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(

            icon: Icon(Icons.search),
            label: 'ຄົ້ນຫາ',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'ແຈ້ງເຕືອນ',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'ຕິດຕາມ',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: 'ຂໍ້ມູນສ່ວນໂຕ',

          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 184, 133, 13),
        onTap: _onItemTapped,
      ),
    );

  }



//BottomSearch Method



}
