import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/models/shared/parmContainer.dart';
import 'package:vtms_v6/services/serverSide/vtmsJSON.dart';

class SearchedParm extends StatefulWidget {

  @override
  _SearchedParmState createState() => _SearchedParmState();
}

class _SearchedParmState extends State<SearchedParm> {
  Map data = {};
  String _uMMD;

  final _textStyle1 = TextStyle(color: red900, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'inconsolata');
  final _textStyle2 = TextStyle(color: fullWhite, fontSize: 16);
  String d = String.fromCharCode($deg); // Degree icon
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments; // Reference to data map from here
    _uMMD = data['MMD'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        title: Text('View Parameters', style: customtxtStyle),
      ),

      body: CustomContainer(
        child: SingleChildScrollView(
          child: Column(    
            crossAxisAlignment: CrossAxisAlignment.start,      
            children: [ 
              SizedBox(height: 20),        
              Center(
                child: FormatButton(
                  fontSize: 15,
                  text: 'EXIT',
                  buttonWidth: 0.28,
                  color: red600,
                  onPressed: () { Navigator.of(context).pushNamedAndRemoveUntil('/mainFrame', (Route<dynamic>route) => false); },
                ),
              ),
              SizedBox(height: 10), 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Time  ', style: _textStyle1.copyWith(color: cyan400)),
                Text('Temperature  ', style: _textStyle1.copyWith(color: cyan100)),
                Text('Humidity  ', style: _textStyle1.copyWith(color: cyan400)),
                Text('Shock & Tilt', style: _textStyle1.copyWith(color: cyan100)),
               ],
             ),
             SizedBox(height: 2.5),
             RefreshTable(
               fetch: fetchMMD(_uMMD),
             )
            ],
          ),
        ),
      )
    );
  }
}