import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/services/serverSide/database.dart';

class Confirmation extends StatefulWidget {

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  Map data = {};
  final _formKey = GlobalKey<FormState>();
  final ShipmentDetails _uDetails = ShipmentDetails();

  // ignore: unused_field
  bool _autovalidate = false;
  final _textStyle1 = TextStyle(fontSize: 18, letterSpacing: 1, color: Colors.yellow[800], fontWeight: FontWeight.normal);
  final _textStyle2 = TextStyle(fontSize: 18, letterSpacing: 1.5, color: Colors.deepOrange[400], fontWeight: FontWeight.bold);

  String sid, uid, supplier, customer, vials, dispatch, arrival, driver, _currentStatus, comments, status; 
  final List<String> dStatus = ['Unconfirmed', 'Today', 'In Transport', 'Delivered'];
  
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    uid       = data['uid'];
    sid       = data['sid'];  // auto generated shipment ID
    vials     = data['vaccine'];   // vial count
    supplier  = data['supplier'];
    customer  = data['customer'];
    dispatch  = data['dispatch'];  // dispatch time 
    arrival   = data['arrival'];  // arrival time 
    driver    = data['driver'];    //driver name
    comments  = data['comments'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        title: Text('Confirmation Page', style: customtxtStyle),
      ),

      body: CustomContainer(
        child: Form(key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Your shipment details have been successfully captured   Save or Delete your new entry', 
                style: TextStyle(fontSize: 15, color: fullWhite), textAlign: TextAlign.center),
              SizedBox(height: 15),

              RichText(text: TextSpan(
                  text: 'Generated Shipment ID: ', style: _textStyle1,
                  children: [ TextSpan(text: '$sid', style: _textStyle2)  ],
                  )),
              SizedBox(height: 5),

              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: lighterBrown,
                    ),
                  child:DropdownButtonFormField(
                  focusColor: lightBrown,
                  value: _currentStatus ?? null,
                  items: dStatus.map((value){
                      return DropdownMenuItem(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                  onChanged: (val) => setState(() => _currentStatus = val),
                  validator: (value) => value == null ? 'Field Required' : null,

                  decoration: InputDecoration(hintText: 'Delivery Status (Required)',
                    contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    fillColor: lighterBrown,
                    filled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: fullBlack, width: 2.5)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: red900,    width: 2.5)),
                    ),
              )) ),
              Text('Save Shipment without MMD linked', style: TextStyle(fontSize: 16, color: cyan200, fontFamily: 'inconsolata')),  
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonExtra(text: 'DELETE',
                  color: pageBackground,
                  textColor: red600,
                  bHeight: 38,
                  bWidth: 115,
                  fontSize: 16,
                  borderColor: red900,
                  onPressed: () { Navigator.pop(context); },
                ),
                SizedBox(width: 15),
                  ButtonExtra(text: 'SAVE',
                  color: pageBackground,
                  textColor: btnGreen2,
                  bHeight: 38,
                  bWidth: 115,
                  fontSize: 16,
                  borderColor: btnGreen2,
                  onPressed: () { 
                    if (_formKey.currentState.validate()){
                        _uDetails.shipmentEntry(uid, supplier, customer, sid, comments, dispatch, _currentStatus, vials, driver, arrival, context);
                    }else{
                      setState(() { _autovalidate = true; });
                    }},
                ),
                ],
              ),
              SizedBox(height: 15),
              Text('Alternatively', style: TextStyle(fontSize: 17, color: cyan200, fontFamily: 'inconsolata')),
              Text('Scan QR Code to Link MMD to Created Shipment', style: TextStyle(fontSize: 16, color: cyan200, fontFamily: 'inconsolata')),
              ButtonExtra(text: 'SCAN',
                  color: pageBackground,
                  textColor: amber900,
                  bHeight: 38,
                  bWidth: 110,
                  fontSize: 16,
                  borderColor: amber900,
                  onPressed: () {  if (_formKey.currentState.validate()){
                      Navigator.pushNamed(context, '/shipmentQR', 
                      arguments: {
                        'supplier': supplier        ?? 'null',
                        'customer': customer        ?? 'null',
                        'vaccine':  vials           ?? 'null',
                        'dispatch': dispatch        ?? 'Not Set',
                        'arrival':  arrival         ?? 'Not Set',
                        'driver':   driver          ?? 'null',
                        'comments': comments        ?? 'null',
                        'uid':      uid             ?? 'null',
                        'sid':      sid             ?? 'null',
                        'status':   _currentStatus  ?? 'null'
                        }); 
                      }else{
                        setState(() { _autovalidate = true; });
                      }
                    },
                ), 
            ],
          ),
        ),
      ),
    );
  }
}