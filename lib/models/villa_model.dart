import 'package:sewa_villa/models/activity_model.dart';
import 'package:sewa_villa/profile_matching.dart';

import 'activity_model.dart';

class Villa {
  final String imageUrl;
  final String description;
  final String nama;
  final int harga;
  final int kapasitas;
  final List<String> fasilitas;
  final List<Activity> activities;
  final double latitude;
  final double longitude;
  int get fasilitasLength => fasilitas.length;

  const Villa({
    this.imageUrl,
    this.description,
    this.nama,
    this.harga,
    this.kapasitas,
    this.fasilitas,
    this.activities,
    this.latitude,
    this.longitude,
  });
}
