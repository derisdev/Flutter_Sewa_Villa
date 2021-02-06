import 'dart:convert';
import 'package:sewa_villa/models/activity_model.dart';

List<VillaModelRevisi> villaFromJson(String str) =>
    List<VillaModelRevisi>.from(json.decode(str).map((x) => VillaModelRevisi.fromJson(x)));

String villaToJson(List<VillaModelRevisi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VillaModelRevisi {
  int id;
  String imageUrl;
  String description;
  String nama;
  String harga;
  String kapasitas;
  final String fasilitas;
  final String latitude;
  final String longitude;
  int get fasilitasLength => fasilitas.length;

  VillaModelRevisi({
    this.id, 
    this.imageUrl,
    this.description,
    this.nama,
    this.harga,
    this.kapasitas,
    this.fasilitas,
    this.latitude,
    this.longitude
    
  });

  factory VillaModelRevisi.fromJson(Map<String, dynamic> json) => VillaModelRevisi(
        id: json["id"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        nama: json["nama"],
        harga: json["harga"],
        kapasitas: json["kapasitas"],
        fasilitas: json["fasilitas"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "description": description,
        "nama": nama,
        "harga": harga,
        "kapasitas": kapasitas,
        "fasilitas": fasilitas,
        "latitude": latitude,
        "longitude": longitude
      };
}