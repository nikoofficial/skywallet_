import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skywallet/Modules/Helpers/Converter.dart';
import 'package:skywallet/Modules/Variables/Global.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';
import 'package:skywallet/Pages/MainMenus/DashboardPage/gethistory.dart';
import 'package:skywallet/Pages/MainMenus/DashboardPage/gettotal.dart';
import 'package:skywallet/Pages/SubMenus/AddKeuanganPage/index.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    //double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: navbarBg,
            title: const Text('Catatan Keuangan'),
            actions: const [],
          ),
          body: Container(
            color: whiteColor,
            child: ListView(children: [
              Container(
                color: navbarBg,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left_outlined,
                        color: primaryColor,
                        size: 30,
                      ),
                      tooltip: 'Previous Month',
                      onPressed: () {
                        setState(() {
                          monthCtrl = monthCtrl.add(const Duration(days: -30));
                        });
                      },
                    ),
                    const Spacer(),
                    Text(getMonthView(monthCtrl),
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right_outlined,
                        color: primaryColor,
                        size: 30,
                      ),
                      tooltip: 'Next Month',
                      onPressed: () {
                        setState(() {
                          monthCtrl = monthCtrl.add(const Duration(days: 30));
                        });
                      },
                    ),
                  ],
                ),
              ),
              Gettotal(),
              Gethistory()
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddKeuanganPage()));
            },
            backgroundColor: navbarBg,
            child: const Icon(Icons.add),
          ),
        ));
  }
}
