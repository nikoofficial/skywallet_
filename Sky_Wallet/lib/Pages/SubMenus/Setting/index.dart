import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skywallet/Components/Dialogs/failed.dart';
import 'package:skywallet/Modules/Services/Auth/Commands/commands.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';
import 'package:skywallet/Pages/SubMenus/LoginPage/index.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  LoginCommandsService loginService;
  File _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _showPicker(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_library,
                        color: Color.fromARGB(255, 21, 0, 155)),
                    title: Text('Photo Library',
                        style:
                            TextStyle(color: Color.fromARGB(255, 21, 0, 155))),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    tileColor: Colors.white,
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera,
                        color: Color.fromARGB(255, 21, 0, 155)),
                    title: Text('Camera',
                        style:
                            TextStyle(color: Color.fromARGB(255, 21, 0, 155))),
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    tileColor: Colors.white,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    loginService = LoginCommandsService();
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
          },
          color: const Color.fromARGB(255, 21, 0, 155),
        ),
        title: Text('Pengaturan', style: kataTextStyle.copyWith(fontSize: 24)),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  color: const Color.fromARGB(255, 21, 0, 155),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 56),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile)
                          : AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                ),
                SizedBox(height: 49),
                Container(
                  width: 325,
                  height: 53,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(
                          color: const Color.fromARGB(255, 21, 0, 155),
                          width: 3),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Beri Penilaian",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 21, 0, 155),
                          fontSize: 25,
                          fontWeight: bold),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: 325,
                  height: 53,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(
                          color: const Color.fromARGB(255, 21, 0, 155),
                          width: 3),
                    ),
                    onPressed: () {
                      loginService.getsignout().then((response) {
                        setState(() => _isLoading = false);
                        var status = response[0]['status'];
                        var body = response[0]['message'];

                        if (status == "success") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  FailedDialog(text: body));
                        }
                      });
                    },
                    child: Text(
                      "Keluar",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 21, 0, 155),
                          fontSize: 25,
                          fontWeight: bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
