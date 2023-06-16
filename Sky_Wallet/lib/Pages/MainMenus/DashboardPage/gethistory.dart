import 'package:flutter/material.dart';
import 'package:skywallet/Modules/Models/Keuangan.dart';
import 'package:skywallet/Modules/Services/keuangan.dart';

class Gethistory extends StatefulWidget {
  Gethistory({Key key}) : super(key: key);
  @override
  _Gethistory createState() => _Gethistory();
}

class _Gethistory extends State<Gethistory> with TickerProviderStateMixin {
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
        future: apiService.gethistory(),
        builder: (BuildContext context,
            AsyncSnapshot<List<gethistorymodel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<gethistorymodel> contents = snapshot.data;
            return _buildListView(contents);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildListView(List<gethistorymodel> contents) {
    //double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
            children: contents.map((e) {
          return InkWell(
            onTap: () {},
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.type_keuangan),
                      Text(e.tanggal_keuangan),
                    ],
                  ),
                  Text(e.jumlah_keuangan.toString())
                ],
              ),
            ),
          );
        }).toList()));
  }
}
