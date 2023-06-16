import 'package:flutter/material.dart';
import 'package:skywallet/Modules/Models/Keuangan.dart';
import 'package:skywallet/Modules/Services/keuangan.dart';

class Gettotal extends StatefulWidget {
  Gettotal({Key key}) : super(key: key);
  @override
  _Gettotal createState() => _Gettotal();
}

class _Gettotal extends State<Gettotal> with TickerProviderStateMixin {
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
        future: apiService.gettotal(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Counttotalmodels>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Counttotalmodels> contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Counttotalmodels> contents) {
    //double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        SizedBox(
          width: fullWidth * 0.3,
          child: Column(
            children: [
              Text("Pemasukan", style: TextStyle(fontSize: 14)),
              Text(contents[0].pemasukan,
                  style: TextStyle(fontSize: 12, color: Colors.green)),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          width: fullWidth * 0.3,
          child: Column(
            children: [
              Text("Pengeluaran", style: TextStyle(fontSize: 14)),
              Text(contents[0].pengeluaran,
                  style: TextStyle(fontSize: 12, color: Colors.red)),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
            width: fullWidth * 0.3,
            child: Column(
              children: [
                Text("Total", style: TextStyle(fontSize: 14)),
                Text(contents[0].total, style: TextStyle(fontSize: 12)),
              ],
            ))
      ]),
    );
  }
}
