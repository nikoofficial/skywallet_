import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skywallet/Modules/Models/Keuangan.dart';
import 'package:skywallet/Modules/Services/keuangan.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';
import 'package:skywallet/Pages/SubMenus/BookmarkPop/GetBookmark.dart';

class LaporanKeuangan extends StatefulWidget {
  LaporanKeuangan({Key key, this.page}) : super(key: key);
  DateTime page;
  @override
  _LaporanKeuanganState createState() => _LaporanKeuanganState();
}

class _LaporanKeuanganState extends State<LaporanKeuangan> {
  KeuanganService apiService;

  @override
  void initState() {
    super.initState();
    apiService = KeuanganService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: FutureBuilder(
        future: apiService.getTotalSpendDay(DateFormat("M").format(widget.page).toString(), DateFormat("yyyy").format(widget.page).toString(), "pemasukan"),
        builder: (BuildContext context,
            AsyncSnapshot<List< QueriesKeuanganLineChartModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List< QueriesKeuanganLineChartModel> contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }


  @override
  Widget _buildListView(List<QueriesKeuanganLineChartModel> contents) {
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
                children: contents.map((content) {
                  return InkWell ( onTap:() {
                
              }, child: Card(
                child: ListTile(
                  title: Text("Rp. ${content.total}"),
                  subtitle: Text("Day. ${content.ctx}") ,
                  
                )
              ));
                }).toList()
              )
             
 
          );
          
       
  }
}
