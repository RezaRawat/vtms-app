import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customContainer.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: fullBlack,
          strokeWidth: 6,
          valueColor: AlwaysStoppedAnimation(Colors.deepPurple[200]),
        ),
      ),
      
    );
  }
}

