class UserModel {
  String? nik;
  String? nama;
  int? umur;
  String? kota;

  UserModel({this.nik, this.nama, this.umur, this.kota});

  UserModel.fromJson(Map<String, dynamic> json) {
    nik = json['nik'] as String?;
    nama = json['nama'] as String?;
    umur = json['umur'] as int?;
    kota = json['kota'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nik'] = this.nik;
    data['nama'] = this.nama;
    data['umur'] = this.umur;
    data['kota'] = this.kota;
    return data;
  }
}
