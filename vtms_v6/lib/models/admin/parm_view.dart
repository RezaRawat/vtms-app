import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customContainer.dart';
import "package:charcode/charcode.dart";
import 'package:vtms_v6/models/shared/parmContainer.dart';
import 'package:vtms_v6/services/serverSide/vtmsJSON.dart';


class DbParameters extends StatefulWidget {

  @override
  _DbParametersState createState() => _DbParametersState();
}

class _DbParametersState extends State<DbParameters> {
  bool loading = false;
  Map data = {};
  String _uSID, arrivalT;
  final _textStyle1 = TextStyle(color: red600, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'inconsolata');
  final _textStyle2 = TextStyle(color: fullWhite, fontSize: 16);
  final _textStyle3 = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  String d = String.fromCharCode($deg); // Degree icon
  
  void initState(){
    refresh(); // check for new data every 25 seconds
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments; // Reference to data map from here
    _uSID  = data['SID'].toString().toUpperCase();
    arrivalT    = data['aTime'];
    List<String> _feedback = ['N', 'T', 'H'], storeFeed =[], storeTemp =[], storeHum =[];
    var feed, temp, hum;
    int itemLength;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: appBarColor,
        title: Text('Parameters', style: customtxtStyle),
        actions: [
          // ignore: deprecated_member_use
          FlatButton.icon(
            onPressed: () { Navigator.pushReplacementNamed(context, '/viewParm', arguments: {'SID': _uSID, 'aTime': arrivalT} ); },
            icon: Icon(Icons.refresh, color: Colors.black87, size: 25),
            label: Text('Refresh', style: TextStyle(color: Colors.black87, fontSize: 18, fontFamily: 'nasalization', fontWeight: FontWeight.bold)),
          )
        ],
      ),

      body: CustomContainer(
        child: SingleChildScrollView(
          child: Column(    
            crossAxisAlignment: CrossAxisAlignment.start,      
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(75, 5, 75, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                      text: 'Shipment ID: ', style: _textStyle1.copyWith(color: lightBlue600, fontSize: 20),
                      children: [ TextSpan(text: ' $_uSID', style: _textStyle2.copyWith(color: lightPurple, fontSize: 20)) ],
                    ) ),
                    RichText(text: TextSpan(
                      text: 'Arrival Time: ', style: _textStyle1.copyWith(color: lightBlue600, fontSize: 20),
                      children: [ TextSpan(text: '$arrivalT', style: _textStyle2.copyWith(color: lightPurple, fontSize: 20)) ],
                    ) ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 20,
                      child: FutureBuilder(
                        //future: refreshData(_uSID),
                       future: fetchDATA(_uSID),
                       builder: (BuildContext context, snapshot) {
                         if (snapshot.connectionState != ConnectionState.done) {
                           return Center(child: Text('Loading..', style: TextStyle(color: fullWhite)));
                         }else{
                           return ListView.builder(
                             itemCount: snapshot.data.length,
                             shrinkWrap: true,
                             itemBuilder: (BuildContext context, index) {
                               itemLength = snapshot.data.length;
                               VtmsFetch fetch = snapshot.data[itemLength-1];
                               feed = fetch.feedback;
                               temp = fetch.temperature;
                               hum  = fetch.humidity;
                               for(int i=0; i<itemLength; i++){
                                 storeFeed.add(feed.toString());
                                 storeTemp.add(temp.toString());
                                 storeHum.add(hum.toString());
                               }

                               if (storeFeed[storeFeed.length-1] == _feedback[0]){ // N - Normal
                                 return Center(child: Text('Normal Internal Environment', style: _textStyle3.copyWith(color: fullWhite)));
                               }else if (storeFeed[storeFeed.length-1] == _feedback[1]){ // T - Temperature Warning
                                 return Center(child: Text('Temperature Warning!   ${storeTemp[storeFeed.length-1]}${d}C', style: _textStyle3.copyWith(color: fullRed)));
                               }else if (storeFeed[storeFeed.length-1] == _feedback[2]){ // H - Humidity Warning
                                 return Center(child: Text('Lid Potentially Openned!  ${storeHum[storeFeed.length-1]}', style: _textStyle3.copyWith(color: fullRed)));
                               }
                             }
                           );
                         }
                       }
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Time  ', style: _textStyle1),
                Text('Temperature  ', style: _textStyle1.copyWith(color: btnGreen1)),
                Text('Humidity  ', style: _textStyle1),
                Text('Shock & Tilt', style: _textStyle1.copyWith(color: btnGreen1)),
               ],
             ), 
             SizedBox(height: 2.5),
             RefreshTable(  fetch: fetchDATA(_uSID) ),
            ],
          ),
        ),
      ),
      
    );
  }

  Future refresh() async{
    var oneSec = const Duration(seconds: 25);
    Timer.periodic(oneSec, (Timer t) => setState(() { fetchDATA(_uSID); }));
  }

}