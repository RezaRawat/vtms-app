import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';


class CustomContainer extends StatelessWidget {
  final Widget child;
  // constructor
  const CustomContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: pageBackground,
      child: child,
    );
  }
}

const customtxtStyle = TextStyle(
  letterSpacing: 2.0,
  fontWeight: FontWeight.bold,
  fontSize: 24.0,
  color: fullBlack,
  fontFamily: 'primeRegular'
);