import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FetchAktivitas {


  Future storeAktivitas(Map dataAktivitas) async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/aktivitas";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: dataAktivitas);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future updateAktivitas(int id, imageUrl, String name, String type, String startTimes, String rating, String price) async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/aktivitas/$id";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          "imageUrl": imageUrl,
          "name": name,
          "type": type,
          "startTimes": startTimes,
          "rating": rating,
          "price": price,
          '_method' : 'PATCH'
        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }

  Future getAllAktivitas() async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/aktivitas";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['aktivitas'];
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future showAktivitas(int idAktivitas) async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/aktivitas/$idAktivitas";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['aktivitas'];
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }


  Future deleteAktivitas(int idAktivitas) async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/aktivitas/$idAktivitas";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
    body: {
      '_method' : 'DELETE'
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    }

    else if (response.statusCode == 404) {
      showToast('Data tidak ditemukan');
      return false;
    }

    else {
      showToast('Terjadi kesalahan');
      return false;
    }
  }

}



showToast(String text) {
  Fluttertoast.showToast(
      msg:
      text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 14.0,
      backgroundColor: Colors.grey,
      textColor: Colors.white);
}
