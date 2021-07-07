import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/models/shared/viewComments.dart';


class LoggedIn extends StatefulWidget {

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {

  void _showComments(String sendComment) {
      // function repsonsible for showing bottom sheet
      showModalBottomSheet(context: context, builder: (context) {
          return Container(
            height: 300,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(50)),
              child: CommentsForm(comment: sendComment),  
          ) );
      });
    }
  // Access user data thats pushed from the login screen
  Map data = {};
  String userName, userID, userSID, vials, mmdID, dTime, aTime, status, driver, comments;
  // custom text styles
  final _textStyle1 = TextStyle(fontSize: 18, letterSpacing: 1,   color: fullWhite,              fontWeight: FontWeight.normal);
  final _textStyle2 = TextStyle(fontSize: 18, letterSpacing: 1.5, color: Colors.deepOrange[400], fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments; // Reference to data map from here
    // Store data from Map -> Startpage
    userID      = data['UserID'];
    userName    = data['UserNAME'];
    userSID     = data['shipID'].toString().toUpperCase();
    vials       = data['vials'];
    mmdID       = data['vials'];   
    dTime       = data['dTime'];
    aTime       = data['aTime'];
    driver      = data['driver'];
    status      = data['status'];
    comments    = data['comments'] ?? 'null';

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
       appBar: AppBar(
        centerTitle: false,
        backgroundColor: appBarColor,
        title: Text('Admin Access', style: customtxtStyle.copyWith(fontSize: 21)),
        actions: [
          // ignore: deprecated_member_use
          FlatButton.icon(
            onPressed: () { Navigator.pushReplacementNamed(context, '/mainFrame'); },
            icon: Icon(Icons.person, color: Colors.black87),
            label: Text('LOGOUT', style: TextStyle(color: Colors.black87, fontSize: 18, fontFamily: 'nasalization')),
          )
        ],
      ),

      body: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Welcome $userName', 
                        style: TextStyle(fontSize: 20, letterSpacing: 2, color: Colors.green[100])),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: RichText(text: TextSpan(
                        text: 'Shipment ID: ', style: _textStyle1,
                        children: [ TextSpan(text: '$userSID', style: _textStyle2) ],
                ) ),
                    ),
              ] ) ),

              SizedBox(height: 20),
              FormatButton(text: 'View Tracked Parameters',
                color: lightBlue600,
                fontSize: 16,
                buttonWidth: 0.67,
                onPressed: () { Navigator.pushNamed(context, '/viewParm', arguments: { 'SID': userSID, 'aTime': aTime }); },
            ),
              FormatButton(text: 'Create New Shipment',
                color: lightBlue600,
                fontSize: 16,
                buttonWidth: 0.67,
                onPressed: () { Navigator.pushNamed(context, '/addShipment', arguments: { 'userUID': userID }); },
            ),
            IconButtonY(text: 'Scan New MMD',
              icon: Icon(Icons.center_focus_weak_rounded, color: fullBlack),
              color: lightPurple,
              borderColor: prefixIcon,
              fontSize: 16,
              bHeight: 40,
              bWidth: 210,
              onPressed: () { Navigator.pushNamed(context, '/QR'); },
            ),
            IconButtonY(text: 'View Comments',
              icon: Icon(Icons.comment_outlined, color: fullBlack),
              color: lightPurple,
              borderColor: prefixIcon,
              fontSize: 16,
              bHeight: 40,
              bWidth: 210,
              onPressed: () => _showComments(comments),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(text: TextSpan(
                      text: 'Dispatch Time: ', style: _textStyle1,
                      children: [ TextSpan(text: '      $dTime', style: _textStyle2) ]
                    )),
                  SizedBox(height: 2.5), 
                  RichText(text: TextSpan(
                      text: 'Arrival Time: ', style: _textStyle1,
                      children: [ TextSpan(text: '         $aTime', style: _textStyle2) ]
                    )),
                  SizedBox(height: 2.5),  
                  RichText(text: TextSpan(
                      text: 'Vaccine Vials: ', style: _textStyle1,
                      children: [ TextSpan(text: '       $vials', style: _textStyle2) ]
                    )),
                    SizedBox(height: 10),
                    RichText(text: TextSpan(
                      text: 'Driver Name: ', style: _textStyle1,
                      children: [ TextSpan(text: '         $driver', style: _textStyle2.copyWith(color: red600)) ]
                    )),
                  SizedBox(height: 2.5), 
                    RichText(text: TextSpan(
                      text: 'Transport Status: ', style: _textStyle1,
                      children: [ TextSpan(text: '  $status', style: _textStyle2.copyWith(color: red600)) ]
                    )),
                ],

              ),
            )
          ],
        ),
      ),
      )
    );
  }
}