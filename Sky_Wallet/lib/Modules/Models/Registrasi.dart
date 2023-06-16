import 'dart:convert';

class RegistrasiModel {
  String nama;
  String username;
  String email;
  String password;

  RegistrasiModel({
    this.nama,
    this.username,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "username": username,
      "email": email,
      "password": password
    };
  }
}

String RegistrasiModelToJson(RegistrasiModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
