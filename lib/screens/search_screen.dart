import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sewa_villa/models/villa_model_revisi.dart';
import 'package:sewa_villa/profile_matching.dart';
import 'package:sewa_villa/screens/villa_screen.dart';
import 'package:sewa_villa/service/fetchvilla.dart';

class SearchScreen extends StatefulWidget {
  final int harga;
  final Position currentPosition;
  final int kapasitas;

  SearchScreen(
    this.harga,
    this.currentPosition,
    this.kapasitas,
  );

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<int> villaTerbaik = [];

  List<VillaModelRevisi> villaList = [];

  @override
  void initState() {
    super.initState();
      initDataVilla();
    
  }

  initDataVilla() {

    FetchVilla fetchVilla = FetchVilla();
    fetchVilla.getAllVilla().then((value){
      if(value!=false){
        setState(() {
          for (Map i in value) {
          villaList.add(VillaModelRevisi.fromJson(i));
        }
        });
      }
      else {
        setState(() {
        });
      }
    });
  }

  String formatCurrency(int value) {
    return NumberFormat.currency(
      locale: "id_ID",
      symbol: "Rp. ",
      decimalDigits: 0,
    ).format(value);
  }
  String formatCurrency2(int value) {
    return NumberFormat.currency(
      locale: "id_ID",
      symbol: "",
      decimalDigits: 0,
    ).format(value);
  }

  String formatDesimal(int value) {
    return NumberFormat.currency(
      symbol: "",
      decimalDigits: 0,
    ).format(value);
  }

  Future<List<IndexPoint>> compare(
      int hargaUser, Position currentPosition, int kapasitasUser) async {
    var pm = new ProfileMatching(
      currentHarga: hargaUser,
      currentKapasitas: kapasitasUser,
      currentLatitude: currentPosition.latitude,
      currentLongitude: currentPosition.longitude,
      datas: villaList,
    );
    await Future.delayed(Duration(seconds: 1));
    return await pm.perhitungan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<IndexPoint>>(
          future: compare(widget.harga, widget.currentPosition, widget.kapasitas),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(child: Text("Data error"));
            } else if (snapshot.hasData) {
              final villas = snapshot.data;
              var listView = ListView.builder(
                itemCount: villas.length == null ? 0 : villas.length,
                itemBuilder: (context, index) {
                  final villa = villas[index];
                  return index>10? Container() : ListTile(
                    title: Text(villa.villa.nama, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Jarak: "),
                            Text("${formatDesimal(villa.jarak)} m", style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        SizedBox(width: 20,),
                        Row(
                          children: <Widget>[
                            Text("Harga: "),
                            Text("${formatCurrency2(villa.harga)}", style: TextStyle(color: Colors.black))
                          ],
                        )
                      ],
                    ),
                    trailing: Chip(
                      label: Text(
                        " ${villa.poin.toString()}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color(0xFF3EBACE),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VillaScreen(
                            idVilla: villa.villa.id,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Harga", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 3),
                            Text(formatCurrency(widget.harga)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Koordinat saat ini",style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 3),
                            Text(
                                "${widget.currentPosition.latitude}, ${widget.currentPosition.longitude}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Kapasitas",style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 3),
                            Text("${widget.kapasitas}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: listView,
                  ),
                ],
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Color(0xFF3EBACE),
              ));
            }
          },
        ),
      ),
    );
  }
}
