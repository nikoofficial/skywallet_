import 'package:flutter/material.dart';
import 'package:skywallet/Components/Dialogs/failed.dart';
import 'package:skywallet/Components/Navbar.dart';
import 'package:skywallet/Modules/Models/Auth/Commands/commands.dart';
import 'package:skywallet/Modules/Services/Auth/Commands/commands.dart';
import 'package:skywallet/Modules/Variables/Theme.dart';
import 'package:skywallet/Pages/MainMenus/DashboardPage/index.dart';
import 'package:skywallet/Pages/SubMenus/RegisterPage/index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  LoginCommandsService loginService;

  @override
  void initState() {
    super.initState();
    loginService = LoginCommandsService();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // Google sign-in was canceled
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print(e.toString());
      // Handle any errors that occur during Google sign-in
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sky Wallet',
                  style:
                      textTextStyle.copyWith(fontSize: 50, fontWeight: bold)),
              const SizedBox(height: 11),
              Text(
                'Yuk, Catat Keuanganmu sehari-hari',
                style: secondaryTextStyle.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 64,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style:
                        textTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                          width: 3,
                          color: const Color.fromARGB(255, 77, 53, 228)),
                      color: whiteColor,
                    ),
                    child: TextField(
                      controller: EmailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 17)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Password',
                    style:
                        textTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                          width: 3,
                          color: const Color.fromARGB(255, 77, 53, 228)),
                      color: whiteColor,
                    ),
                    child: TextFormField(
                      controller: PasswordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(),
                  Text(
                    'Lupa Password?',
                    style: textTextStyle.copyWith(fontSize: 12),
                  )
                ],
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 21, 0, 155),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    LoginModel data = LoginModel(
                      email: EmailController.text.trim(),
                      password: PasswordController.text.trim(),
                    );

                    //Validator
                    if (data.email.isNotEmpty && data.password.isNotEmpty) {
                      loginService.addLogin(data).then((response) {
                        setState(() => _isLoading = false);
                        var status = response[0]['message'];
                        var body = response[0]['body'];

                        if (status == "success") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavBar()),
                          );
                        } else {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  FailedDialog(text: body));

                          EmailController.clear();
                          PasswordController.clear();
                        }
                      });
                    } else {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => FailedDialog(
                              text: "Login failed, field can't be empty"));
                    }
                  },
                  child: Text('LOGIN',
                      style: whiteTextStyle.copyWith(
                          fontWeight: bold, fontSize: 20)),
                ),
              ),
              SizedBox(height: 18),
              Container(
                child: Text(
                  "OR",
                  style: TextStyle(fontWeight: bold),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffD6CDFE)),
                  onPressed: () async {
                    UserCredential userCredential = await signInWithGoogle();
                    if (userCredential == null) {
                      // Jika berhasil sign in dengan Google, lanjutkan ke halaman beranda
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => NavBar()),
                        (route) => true,
                      );
                    } else {
                      // Jika terjadi kesalahan, tampilkan pesan error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Gagal melakukan sign in dengan Google'),
                        ),
                      );
                    }
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 12),
                        Text("SIGN IN WITH GOOGLE",
                            style: TextStyle(fontWeight: bold))
                      ]),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum mempunyai akun?",
                      style: textTextStyle.copyWith(fontSize: 10)),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: Text('Register',
                        style: textTextStyle.copyWith(
                            fontSize: 10, fontWeight: bold)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
