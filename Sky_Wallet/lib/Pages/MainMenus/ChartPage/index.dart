import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skywallet/Modules/Models/Keuangan.dart';
import 'package:skywallet/Modules/Services/keuangan.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';
import 'package:skywallet/Pages/MainMenus/ChartPage/ChartKeuangan.dart';
import 'package:skywallet/Pages/SubMenus/BookmarkPop/GetBookmark.dart';
import 'package:skywallet/Pages/SubMenus/LaporanKeuangan/index.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {



  @override
  Widget build(BuildContext context) {
    List<dynamic>contents=[];
    DateTime now =DateTime.now();
    for(int i=0; i<=12; i++){
      contents.add({
        "month" : DateFormat("MMM yyyy").format(now).toString(),
        "page" : now
      });
      now=DateTime(now.year, now.month - 1, now.day);
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: navbarBg,
          title: const Text('Chart'),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => const AlertDialog(
                  title: Text('AlertDialog Title'),
                  content: SizedBox(height: 300, child: GetBookmark()),
                ),
              ),
            ),
          ], ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              TotalSpending(type: "pemasukan"),
              TotalSpending(type: "pengeluaran"),
              Column(
                children: contents.map((content) {
                  return InkWell ( onTap:() {
                    Navigator.push(
                      context,
    MaterialPageRoute(builder: (context) => LaporanKeuangan(page: content["page"])),
  );
                
              }, child: Card(
                child: ListTile(
                  title: Text("${content["month"]}"),
                  
                  
                )
              ));
                }).toList()
              )
             
            ]
          ));
          
       
  }
}
