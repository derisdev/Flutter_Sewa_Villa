import 'package:geolocator/geolocator.dart';
import 'package:sewa_villa/models/villa_model_revisi.dart';

class IndexPoint {
  final VillaModelRevisi villa;
  final int jarak;
  final double poin;
  final int harga;

  const IndexPoint(this.villa, this.jarak, this.poin, this.harga);
}

class ProfileMatching {
  final int currentHarga;
  final int currentKapasitas;
  final double currentLatitude;
  final double currentLongitude;
  List<VillaModelRevisi> datas;

  ProfileMatching({
    this.currentHarga,
    this.currentKapasitas,
    this.currentLatitude,
    this.currentLongitude,
    this.datas,
  });

  void sortedDatas(List<IndexPoint> datas) {
    datas.sort((a, b) => b.poin.compareTo(a.poin));
  }

  int hitungJarak(double x, double y, double a, double b) {
    return distanceBetween(x, y, a, b).round();
  }

  double hitungPoin(int harga, int jarak, int kapasitas, int fasilitas) {
    double pHarga;
    double pJarak;
    double pKapasitas;
    int pFasilitas = fasilitas;

    if (harga <= -500000) {
      pHarga = 0;
    } else if (harga <= -400000 && harga > -500000) {
      pHarga = 1;
    } else if (harga <= -300000 && harga > -400000) {
      pHarga = 2;
    } else if (harga <= -200000 && harga > -300000) {
      pHarga = 3;
    } else if (harga <= -100000 && harga > -200000) {
      pHarga = 4;
    } else if (harga <= 0 && harga > -100000) {
      pHarga = 5;
    } else if (harga <= 100000 && harga > 0) {
      pHarga = 6;
    } else if (harga <= 200000 && harga > 100000) {
      pHarga = 7;
    } else if (harga <= 300000 && harga > 200000) {
      pHarga = 8;
    } else if (harga <= 400000 && harga > 300000) {
      pHarga = 9;
    } else {
      pHarga = 10;
    }

    if (jarak >= 15000) {
      pJarak = 0;
    } else if (jarak <= 10000 && jarak > 9000) {
      pJarak = 1;
    } else if (jarak <= 9000 && jarak > 8000) {
      pJarak = 2;
    } else if (jarak <= 8000 && jarak > 7000) {
      pJarak = 3;
    } else if (jarak <= 7000 && jarak > 6000) {
      pJarak = 4;
    } else if (jarak <= 6000 && jarak > 5000) {
      pJarak = 5;
    } else if (jarak <= 5000 && jarak > 4000) {
      pJarak = 6;
    } else if (jarak <= 4000 && jarak > 3000) {
      pJarak = 7;
    } else if (jarak <= 3000 && jarak > 2000) {
      pJarak = 8;
    } else if (jarak <= 2000 && jarak > 1000) {
      pJarak = 9;
    } else {
      pJarak = 10;
    }

    if (kapasitas <= 0) {
      pKapasitas = 0;
    } else if (kapasitas <= 50 && kapasitas > 0) {
      pKapasitas = 1;
    } else if (kapasitas <= 100 && kapasitas > 50) {
      pKapasitas = 2;
    } else if (kapasitas <= 150 && kapasitas > 100) {
      pKapasitas = 3;
    } else if (kapasitas <= 200 && kapasitas > 150) {
      pKapasitas = 4;
    } else if (kapasitas <= 250 && kapasitas > 200) {
      pKapasitas = 5;
    } else if (kapasitas <= 300 && kapasitas > 250) {
      pKapasitas = 6;
    } else if (kapasitas <= 350 && kapasitas > 300) {
      pKapasitas = 7;
    } else if (kapasitas <= 400 && kapasitas > 350) {
      pKapasitas = 8;
    } else if (kapasitas <= 450 && kapasitas > 400) {
      pKapasitas = 9;
    } else {
      pKapasitas = 10;
    }

    double poinKalkulasi = ((pHarga + pJarak + pKapasitas) * 70 / 100) +
        ((pFasilitas * 5) * (30 / 100));
    return poinKalkulasi;
  }

  Future<List<IndexPoint>> perhitungan() async {
    List<IndexPoint> villaDatas = [];
    int fasilitas;
    int currentHargaBanding;
    int currentKapasitasBanding;

    //foreach loop data villa yang dimasukkan untuk menentukan poin
    for (VillaModelRevisi villa in datas) {
      fasilitas = villa.fasilitas.split(',').length;
      currentHargaBanding = currentHarga - int.parse(villa.harga);
      currentKapasitasBanding = currentKapasitas-int.parse(villa.kapasitas);

      // menghitung jarak berdasar koordinat saat ini dan koordinat villa
      int jarak = hitungJarak(
          currentLatitude, currentLongitude, double.parse(villa.latitude), double.parse(villa.longitude));
      print("jarak: $jarak");
          
      double poin = hitungPoin(
          currentHargaBanding, jarak, currentKapasitasBanding, fasilitas);
      villaDatas.add(IndexPoint(villa, jarak, poin, int.parse(villa.harga)));
    }

    //Di sort desc berdasarkan poin
    sortedDatas(villaDatas);
    return villaDatas;
  }
}
