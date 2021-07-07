import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customContainer.dart';


class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('More Information', style: customtxtStyle),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      
      body: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            Container(height: 300, width: 300,
              decoration: BoxDecoration(shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage('lib/assets/dd.png'),
                  fit: BoxFit.fill 
            ) ) ),
           
          ],
        ),
      ),     
    );
  }
}