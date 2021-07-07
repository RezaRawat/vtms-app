import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


  receiveUrl(){
    //String ngrok = "https://192.168.101.246/reza/";
    String ngrok = "https://a673151843dc.ngrok.io/reza/";
    return ngrok;
  }

 final String ngrokURL = receiveUrl();

class FutureClasses {

Future register(TextEditingController userEmail, TextEditingController userPass, 
                TextEditingController userName,  TextEditingController userSurname, 
                TextEditingController userCont,  BuildContext context) async { // Send Data
  
  String uEmail   = userEmail.text; String uPassword  = userPass.text;
  String uName    = userName.text;  String uSurname   = userSurname.text;
  String uContact = userCont.text;  

  var url = ngrokURL + "user_reg.php";  
  var response = await http.post(Uri.parse(url),
  body: {
    "email":    uEmail,
    "password": uPassword,
    "name":     uName,
    "surname":  uSurname, 
    "contact":  uContact,
  }); 

  var data = json.decode(response.body);
  if(data == "Error"){
    showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Email already exists", textScaleFactor: 1.5),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Retry'),
            onPressed: () { 
              Navigator.of(context).pop();
              userEmail.clear();
               })
        ]));
    }else{
      showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Successful Registration", textScaleFactor: 1.2),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Login From Start Page'),
            onPressed: () { 
              Navigator.pushReplacementNamed(context, '/mainFrame');
               })
        ]));
  }
}




Future<bool> login(String uEmail, String uPassword,
                   BuildContext context, bool select, String userSID) async {
  String userID, userNAME;
  String _shipID, _vials, _dispatchT, _arrivalT, _comments, _driver, _status;
  bool load;

  var url1 = ngrokURL + "user_login.php";
  var response = await http.post(Uri.parse(url1),
  body: {
    "email":    uEmail,
    "password": uPassword,
  }); 

  var url2 = ngrokURL + "fetch_data.php";
  var responseUID = await http.get(Uri.parse(url2)); 
  List dataUID = json.decode(responseUID.body);

  // match UID with user-entered email
  for(int i=0; i<dataUID.length; i++){
    if(dataUID[i]['email'] == '$uEmail'){
      userID   = dataUID[i]['uid'];
      userNAME = dataUID[i]['name'];
    }
  }

  var url3 = ngrokURL + "fetch_shipment.php";
  var responseData = await http.get(Uri.parse(url3)); 
  List data = json.decode(responseData.body);

  // match UID with user-entered email
  for(int i=0; i<data.length; i++){
    if(data[i]['sid'] == '$userSID'){
      _shipID     = data[i]['sid'];
      _vials      = data[i]['vials'];
      _driver     = data[i]['driver'];
      _dispatchT  = data[i]['dispatch_time'];
      _arrivalT   = data[i]['arrival_time'];
      _comments   = data[i]['comments'];
      _status     = data[i]['status'];
    }
  }

  var user = json.decode(response.body);
  if(user == "Success"){
    load = false;
      if (select == true){
        Navigator.of(context).pushNamedAndRemoveUntil('/preLogin', (Route<dynamic>route) => false, arguments: {
                  'UserID':       userID    ?? '--',
                  'UserEmail':    uEmail    ?? '--',  
                  'UserPassword': uPassword ?? '--',
                });
      }else{
        _shipID = userSID;
        Navigator.of(context).pushNamedAndRemoveUntil('/loggedIn', (Route<dynamic>route) => false, arguments: {
                  'UserID':   userID      ?? '--',
                  'UserNAME': userNAME    ?? '--',
                  'shipID':   _shipID     ?? '--',
                  'vials':    _vials      ?? '--',
                  'dTime':    _dispatchT  ?? 'Not Set',
                  'aTime':    _arrivalT   ?? 'Not Set',
                  'driver':   _driver     ?? '--',
                  'status':   _status     ?? '--',
                  'comments': _comments   ?? '--',
                });
      }
    }else{
      load = true;
      showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Email or Password Incorrect", textScaleFactor: 1.2),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Retry'),
            onPressed: () { 
              Navigator.pushReplacementNamed(context, '/mainFrame');
               })
        ]));
    }
    return load;
  }



Future search(String uMMD, BuildContext context) async {
  var url = ngrokURL + "mmd_search.php";
  var response = await http.post(Uri.parse(url),
    body: {
      "MMD": uMMD.toString().toUpperCase(),
    });

  var user = json.decode(response.body);
  if(user == "Success"){
    showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Mobile Monitoring Device Found", textScaleFactor: 1.5),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('OK'),
            onPressed: () { 
              Navigator.pushNamedAndRemoveUntil(context, '/searched', (route) => false, arguments: {"MMD": uMMD});
              }
        )]));

    }else{
      showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Incorrect MMD ID or Does Not Exist", textScaleFactor: 1.2),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Retry'),
            onPressed: () { 
              Navigator.of(context).pushNamedAndRemoveUntil('/mainFrame', (Route<dynamic>route) => false);
               })
        ]));
  }
} // end Future SEARCH


}