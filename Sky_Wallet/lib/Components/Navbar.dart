import 'package:flutter/material.dart';
import 'package:skywallet/Modules/Variables/Global.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';
import 'package:skywallet/Pages/MainMenus/BudgetPage/index.dart';
import 'package:skywallet/Pages/MainMenus/ChartPage/index.dart';
import 'package:skywallet/Pages/MainMenus/ContactPage/index.dart';
import 'package:skywallet/Pages/MainMenus/DashboardPage/index.dart';
import 'package:skywallet/Pages/MainMenus/NewsPage/index.dart';
import 'package:skywallet/Pages/SubMenus/Setting/index.dart';

class NavBar extends StatefulWidget {
  const NavBar({key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<Widget> _widgetOptions = <Widget>[
    const DashboardPage(),
    ChartPage(),
    NewsPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: ClipRRect(
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart), label: "Chart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper), label: "Newspaper"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
            backgroundColor: navbarBg,
            selectedLabelStyle: const TextStyle(fontSize: 14),
            selectedItemColor: primaryColor,
            unselectedItemColor: primaryColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ));
  }
}
