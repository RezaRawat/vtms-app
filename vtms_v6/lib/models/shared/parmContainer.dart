import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/services/loader.dart';
import 'package:vtms_v6/services/serverSide/vtmsJSON.dart';

class RefreshTable extends StatefulWidget {
  final String uSID;
  final Future<List<VtmsFetch>> fetch;
  final Function fetchData;

  const RefreshTable({Key key, 
    this.uSID,    
    this.fetch,     
    this.fetchData
  }) : super(key: key);

  @override
  _RefreshTableState createState() => _RefreshTableState();
}

class _RefreshTableState extends State<RefreshTable> {
  String d = String.fromCharCode($deg); // Degree icon
  final _textStyle2 = TextStyle(fontSize: 15.5, letterSpacing: 1.5, color: lightOrange); 
  var sid, humid, stat, temp, time;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: pageBackground,

      child: FutureBuilder(
        future: widget.fetch,
        // ignore: missing_return
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Loader();
            
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                VtmsFetch fetch = snapshot.data[index];
                  sid   = fetch.sid;
                  stat  = fetch.shockTilt;
                  humid = fetch.humidity;
                  temp  = fetch.temperature;
                  time  = fetch.timeStamp.toString().substring(11,16);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 2,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(' $time', style: _textStyle2)],
                    ),),
                    Expanded(flex: 3,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('   $temp$d'+'C', style: _textStyle2)],
                    ),),
                    Expanded(flex: 2,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('  $humid', style: _textStyle2)],
                    ),),
                    Expanded(flex: 3,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('    $stat', style: _textStyle2)],
                    ),),
                  ],
                ); 
              }
            );
          } 
        } 
      ),
    );
  }
}