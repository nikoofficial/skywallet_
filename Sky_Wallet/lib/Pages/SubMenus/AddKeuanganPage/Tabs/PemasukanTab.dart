import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:skywallet/Components/Dialogs/failed.dart';
import 'package:skywallet/Components/Navbar.dart';
import 'package:skywallet/Modules/Helpers/Converter.dart';
import 'package:skywallet/Modules/Models/Keuangan.dart';
import 'package:skywallet/Modules/Services/keuangan.dart';
import 'package:skywallet/Modules/Variables/Global.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';

class PemasukanTab extends StatefulWidget {
  const PemasukanTab({Key key}) : super(key: key);

  @override
  _PemasukanTabState createState() => _PemasukanTabState();
}

class _PemasukanTabState extends State<PemasukanTab> {
  var dateCtrlPemasukan;
  final jumlahCtrl = TextEditingController();
  final deskripsiCtrl = TextEditingController();
  KeuanganService apiService;

  @override
  void initState() {
    super.initState();
    apiService = KeuanganService();
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      children: [
        const Text("Kategori"),
        DropdownButton<String>(
          value: selectedCategory,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String value) {
            // This is called when the user selects an item.
            setState(() {
              selectedCategory = value;
            });
          },
          items: category.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const Text("Jumlah"),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextField(
            controller: jumlahCtrl,
            cursorColor: Colors.white,
            maxLength: 12,
            autofocus: true,
            decoration: InputDecoration(
                hintText: '0',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: TextField(
            controller: deskripsiCtrl,
            minLines: 3,
            maxLines: 3,
            cursorColor: Colors.white,
            maxLength: 255,
            autofocus: true,
            decoration: InputDecoration(
                hintText: 'Catatan',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                fillColor: Colors.white,
                filled: true),
          ),
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                foregroundColor: Colors.black,
                backgroundColor: primaryColor), // <-- TextButton
            onPressed: () {
              final now = DateTime.now();

              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(now.year, now.month, now.day),
                  maxTime: DateTime(now.year + 1, now.month, now.day),
                  onConfirm: (date) {
                setState(() {
                  dateCtrlPemasukan = date;
                });
              }, currentTime: now, locale: LocaleType.en);
            },
            icon: const Icon(
              Icons.calendar_month,
              size: 24.0,
            ),
            label: Text(getSelectDateButtonTitle(dateCtrlPemasukan))),
        ElevatedButton(
          onPressed: () async {
            KeuanganModel data = KeuanganModel(
                type_keuangan: "pemasukan",
                nama_kategori: selectedCategory,
                deskripsi_keuangan: deskripsiCtrl.text,
                jumlah_keuangan: int.parse(jumlahCtrl.text.trim()),
                tanggal_keuangan: validateDatetime(dateCtrlPemasukan));

            //Validator
            if (data.nama_kategori.isNotEmpty &&
                data.deskripsi_keuangan.isNotEmpty &&
                data.jumlah_keuangan >= 500) {
              apiService.addKeuangan(data).then((response) {
                setState(() => _isLoading = false);
                var status = response[0]['message'];
                var body = response[0]['body'];

                if (status == "success") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NavBar()),
                  );
                } else {
                  print(data.tanggal_keuangan);
                  // showDialog<String>(
                  //     context: context,
                  //     builder: (BuildContext context) =>
                  //         FailedDialog(text: body));

                  jumlahCtrl.clear();
                  deskripsiCtrl.clear();
                }
              });
            } else {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      FailedDialog(text: "Login failed, field can't be empty"));
            }
          },
          child: const Text("Simpan"),
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: navbarBg),
        )
      ],
    );
  }
}
