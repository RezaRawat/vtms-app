import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vtms_v6/services/serverSide/authentication.dart'; 

final String ngrokURL = receiveUrl();

List<VtmsFetch> vtmsFetchFromJson(String str) => List<VtmsFetch>.from(json.decode(str).map((x) => VtmsFetch.fromJson(x)));
String vtmsFetchToJson(List<VtmsFetch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VtmsFetch {
    VtmsFetch({
        this.mmdId,       this.sid,
        this.temperature, this.humidity,
        this.shockTilt,   this.feedback,
        this.latitude,    this.longitude,
        this.increment,   this.timeStamp,
    });
    String mmdId;         String sid;
    String temperature;   String humidity;
    String shockTilt;     String feedback;
    String latitude;      String longitude;
    String increment;     DateTime timeStamp;

    factory VtmsFetch.fromJson(Map<String, dynamic> json) => VtmsFetch(
        mmdId:        json["mmd_id"],
        sid:          json["sid"],
        temperature:  json["temperature"],
        humidity:     json["humidity"],
        shockTilt:    json["shock_tilt"],
        feedback:     json["feedback"],
        timeStamp:    DateTime.parse(json["time_stamp"]),
        latitude:     json["latitude"],
        longitude:    json["longitude"],
        increment:    json["increment"],
    );

    Map<String, dynamic> toJson() => {
        "mmd_id":       mmdId,
        "sid":          sid,
        "temperature":  temperature,
        "humidity":     humidity,
        "shock_tilt":   shockTilt,
        "feedback":     feedback,
        "time_stamp":   timeStamp.toIso8601String(),
        "latitude":     latitude,
        "longitude":    longitude,
        "increment":    increment,
    };
}

Future<List<VtmsFetch>> fetchDATA(String uSID) async {
  var url = ngrokURL + "fetch_perSID.php";
  var response1 = await http.post(Uri.parse(url), body: { "SID": uSID });
  //listMMD(uSID);
  return vtmsFetchFromJson(response1.body);
}

listMMD(String uSID) async {
  var url = ngrokURL + "fetch_perMID.php";
  var response1 = await http.post(Uri.parse(url), body: {"MMD": uSID});

  List response = json.decode(response1.body);
}


Future<List<VtmsFetch>> fetchMMD(String uMMD) async {
  var url = ngrokURL + "fetch_perMID.php";
  var response1 = await http.post(Uri.parse(url), body: {"MMD": uMMD});

  return vtmsFetchFromJson(response1.body);
}



