import 'dart:convert';

// Usecase login
class KeuanganModel {
  String type_keuangan;
  String nama_kategori;
  String deskripsi_keuangan;
  int jumlah_keuangan;
  String tanggal_keuangan;

  KeuanganModel({
    this.type_keuangan,
    this.nama_kategori,
    this.deskripsi_keuangan,
    this.jumlah_keuangan,
    this.tanggal_keuangan,
  });

  Map<String, dynamic> toJson() {
    return {
      "type_keuangan": type_keuangan,
      "nama_kategori": nama_kategori,
      "deskripsi_keuangan": deskripsi_keuangan,
      "jumlah_keuangan": jumlah_keuangan,
      "tanggal_keuangan": tanggal_keuangan
    };
  }
}

String KeuanganModelToJson(KeuanganModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

// Usecase get last count body
class Counttotalmodels {
  String total;
  String pemasukan;
  String pengeluaran;

  Counttotalmodels({this.total, this.pemasukan, this.pengeluaran});

  factory Counttotalmodels.fromJson(Map<String, dynamic> map) {
    return Counttotalmodels(
      total: map["total"],
      pemasukan: map["pemasukan"],
      pengeluaran: map["pengeluaran"],
    );
  }
}

List<Counttotalmodels> CounttotalmodelsFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Counttotalmodels>.from(
      data['data'].map((item) => Counttotalmodels.fromJson(item)));
}

class gethistorymodel {
  int id;
  String id_user;
  String type_keuangan;
  String nama_kategori;
  String deskripsi_keuangan;
  int jumlah_keuangan;
  String tanggal_keuangan;
  String created_at;

  gethistorymodel(
      {this.id,
      this.id_user,
      this.type_keuangan,
      this.nama_kategori,
      this.deskripsi_keuangan,
      this.jumlah_keuangan,
      this.tanggal_keuangan,
      this.created_at});

  factory gethistorymodel.fromJson(Map<String, dynamic> map) {
    return gethistorymodel(
      id: map["id"],
      id_user: map["id_user"],
      type_keuangan: map["type_keuangan"],
      nama_kategori: map["nama_kategori"],
      deskripsi_keuangan: map["deskripsi_keuangan"],
      jumlah_keuangan: map["jumlah_keuangan"],
      tanggal_keuangan: map["tanggal_keuangan"],
      created_at: map["created_at"],
    );
  }
}

List<gethistorymodel> gethistorymodelfromjson(String jsonData) {
  final data = json.decode(jsonData);
  return List<gethistorymodel>.from(
      data['data'].map((item) => gethistorymodel.fromJson(item)));
}

class QueriesKeuanganLineChartModel {
  String ctx;
  int total;

  QueriesKeuanganLineChartModel({this.ctx, this.total});

  factory QueriesKeuanganLineChartModel.fromJson(Map<String, dynamic> map) {
    return QueriesKeuanganLineChartModel(
      ctx: map["context"],
      total: map["total"],
    );
  }
}

List<QueriesKeuanganLineChartModel> queriesKeuanganLineChartModelFromJson(
    String jsonData) {
  final data = json.decode(jsonData);
  return List<QueriesKeuanganLineChartModel>.from(
      data['data'].map((item) => QueriesKeuanganLineChartModel.fromJson(item)));
}
