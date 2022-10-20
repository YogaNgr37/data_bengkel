class Bengkel {
  int? id;
  String? motor;
  String? kerusakan;
  String? sparepart;
  String? harga;
  String? biaya;
  String? total;
  String? tanggal;

  Bengkel(
      {this.id,
      this.motor,
      this.kerusakan,
      this.sparepart,
      this.harga,
      this.biaya,
      this.total,
      this.tanggal});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['motor'] = motor;
    map['kerusakan'] = kerusakan;
    map['sparepart'] = sparepart;
    map['harga'] = harga;
    map['biaya'] = biaya;
    map['total'] = total;
    map['tanggal'] = tanggal;

    return map;
  }

  Bengkel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.motor = map['motor'];
    this.kerusakan = map['kerusakan'];
    this.sparepart = map['sparepart'];
    this.harga = map['harga'];
    this.biaya = map['biaya'];
    this.total = map['total'];
    this.tanggal = map['tanggal'];
  }
}
