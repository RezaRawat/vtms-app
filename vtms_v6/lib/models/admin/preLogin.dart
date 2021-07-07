import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/services/loader.dart';
import 'package:vtms_v6/services/serverSide/authentication.dart';
import 'package:vtms_v6/services/serverSide/shipmentJSON.dart';

class SelectSID extends StatefulWidget {

  @override
  _SelectSIDState createState() => _SelectSIDState();
}

class _SelectSIDState extends State<SelectSID> {
  Map data ={};
  final FutureClasses _futureData = FutureClasses();
  final _textStyle = TextStyle(color: fullWhite, fontSize: 18, fontFamily: 'inconsolata');
  String _uID, _uEmail, _uPassw;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    data    = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments; // Reference to data map from here
    _uID    = data['UserID'];
    _uEmail = data['UserEmail']; 
    _uPassw = data['UserPassword'];

    var _sid, _vials;
    List<String> storeSID=[];
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        title: Text('Select Shipment', style: customtxtStyle)),

      body: Container(
        height: size.height,
        width: double.infinity,
        color: pageBackground,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Communicating with Database... ', style: _textStyle),
            Text('Please Wait', style: _textStyle),
            SizedBox(height: 10),
            Text('Select shipment ID to view its details', style: _textStyle),
            SizedBox(height: 10),
            Expanded(
                child: FutureBuilder(
                  future: fetchShipDATA(_uID),
                  builder: (BuildContext context, snapshot){
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Loader();

                      }else if(snapshot.data.length == 0){  
                        _futureData.login(_uEmail, _uPassw, context, false, '');
                        
                      }else{
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          ShipmentFetch fetch = snapshot.data[index];
                            _sid   = fetch.sid;
                            _vials = fetch.vials;
                          for(int i=0;i<snapshot.data.length;i++){         
                              storeSID.add(_sid);
                          }
                          
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                              child: Column(
                                children: [
                                  FormatButton(
                                    text: '$_sid with $_vials Vials', 
                                    buttonWidth: 0.75,
                                    color: pink200,
                                    fontSize: 18,
                                    onPressed: () {
                                      _futureData.login(_uEmail, _uPassw, context, false, storeSID[index*3]);
                                    }
                                  ),
                                  ],
                              )),
                            ],
                          );
                        }
                      );
                    }
                  } 
                ),
            ),
          ],
        ),
      ),
    );
  }
}
