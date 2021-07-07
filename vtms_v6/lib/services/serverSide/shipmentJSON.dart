import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vtms_v6/services/serverSide/authentication.dart';

List<ShipmentFetch> shipmentFetchFromJson(String str) => List<ShipmentFetch>.from(json.decode(str).map((x) => ShipmentFetch.fromJson(x)));
String shipmentFetchToJson(List<ShipmentFetch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

final String ngrokURL = receiveUrl();

class ShipmentFetch {
    ShipmentFetch({
        this.sid,           this.uid,
        this.vials,         this.driver,
        this.dispatchTime,  this.arrivalTime,
        this.comments,      this.status,
    });

    String sid;           String uid;
    String vials;         String driver;
    String dispatchTime;  String arrivalTime;
    String comments;      String status;

    factory ShipmentFetch.fromJson(Map<String, dynamic> json) => ShipmentFetch(
        sid:          json["sid"],
        uid:          json["uid"],
        vials:        json["vials"],
        driver:       json["driver"],
        dispatchTime: json["dispatch_time"],
        arrivalTime:  json["arrival_time"],
        comments:     json["comments"],
        status:       json["status"],
    );

    Map<String, dynamic> toJson() => {
        "sid":            sid,
        "uid":            uid,
        "vials":          vials,
        "driver":         driver,
        "dispatch_time":  dispatchTime,
        "arrival_time":   arrivalTime,
        "comments":       comments,
        "status":         status,
    };
}

Future<List<ShipmentFetch>> fetchShipDATA(String uID) async {
  var url = ngrokURL + "fetch_perUID.php";
  var response1 = await http.post(Uri.parse(url), body: {"UID": uID});
  List response = json.decode(response1.body);

  return shipmentFetchFromJson(response1.body);
}

