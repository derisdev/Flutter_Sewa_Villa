import 'package:flutter/material.dart';
import 'package:sewa_villa/models/villa_model_revisi.dart';
import 'package:sewa_villa/service/fetchvilla.dart';
import '../models/activity_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


class VillaScreen extends StatefulWidget {
  final int idVilla;

  VillaScreen({this.idVilla});

  @override
  _VillaScreenState createState() => _VillaScreenState();
}

class _VillaScreenState extends State<VillaScreen> {

  VillaModelRevisi villaData;

  List<Activity> activityList = [];

  bool isLoading = true;


  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  void initState() { 
    super.initState();
    updateListView();
  }

   updateListView() {

    FetchVilla fetchVilla = FetchVilla();
    fetchVilla.showVilla(widget.idVilla.toString()).then((value){
      if(value!=false){
        setState(() {
          villaData = VillaModelRevisi.fromJson(value);
          for(Map i in value['aktivitas']){
            activityList.add(Activity.fromJson(i));
          }
          isLoading = false;
        });
      }
      else {
        setState(() {
          isLoading = false;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading? Center(
        child: CircularProgressIndicator(backgroundColor: Color(0xFF3EBACE),)
      ): Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Hero(
                  tag: villaData.nama,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: AssetImage(villaData.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.sortAmountDown),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width-20,
                      child: Text(
                      villaData.nama,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 5.0),
                        Text(
                          '${formatCurrency(int.parse(villaData.harga))}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20.0,
                bottom: 20.0,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white70,
                  size: 25.0,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
              itemCount: activityList.length,
              itemBuilder: (BuildContext context, int index) {
                Activity activity = activityList[index];
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                      height: 170.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 112.0,
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    activity.name,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 5,),
                                    Text(
                                      '${formatCurrency2(int.parse(activity.price))} Rupiah',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'per pax',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              activity.type,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 3.0),
                            _buildRatingStars(int.parse(activity.rating)),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    activity.startTimes.split(',')[0],
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    activity.startTimes.split(',')[1],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 15.0,
                      bottom: 15.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          width: 110.0,
                          image: AssetImage(
                            activity.imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
