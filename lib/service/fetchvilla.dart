import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchVilla {


  Future storeVilla(Map dataVilla) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/villa";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: dataVilla);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
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

  Future updatevilla(int idVilla, Map dataVilla) async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/villa/$idVilla";
    var response = await http.post(baseUrl,
        headers: {"Accept": "application/json"},
        body: {
          '_method' : 'PATCH'

        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
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


  Future getAllVilla() async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/villa";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['villas'];
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

  Future showVilla(String idVilla) async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/villa/$idVilla";
    var response = await http.get(baseUrl,
        headers: {"Accept": "application/json"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['villa'];
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


  Future deleteVilla(String idVilla) async {

    String baseUrl =
        "http://villaapi.fillocoffee.web.id/api/v1/villa/$idVilla";
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
