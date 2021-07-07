import 'package:flutter/material.dart';
import 'colorConstants.dart';

class CustomTextField extends StatelessWidget {
  final String    hintText;
  final Function  validator, onChanged;
  final bool      obscureText;
  final TextEditingController controller;
  // Constructor
  const CustomTextField({
    Key key,
    this.hintText,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: TextFormField(
        obscureText: obscureText,
        textAlign: TextAlign.start,
        controller: controller,
        validator: validator,
        onChanged: onChanged,

        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(color: Colors.blue[800], backgroundColor: lighterBrown, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          errorStyle: TextStyle(color: red600, fontSize: 14),
          errorBorder: InputBorder.none,
          fillColor: lighterBrown,
          filled: true,
          hintText: hintText,

          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: fullBlack, width: 2 )
            ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: red900,    width: 2 )
            )
        ),   
      ),   
    );
  }
} // end CustomTextField


class StartTxtField extends StatelessWidget {
  final String    hintText;
  final IconData  icon;
  final Function  validator, onChanged;
  final bool      obscureText;
  final TextEditingController controller;
  // Constructor
  const StartTxtField({
    Key key,
    this.hintText,
    this.icon,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: lighterPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: obscureText,
        textAlign: TextAlign.start,
        controller: controller,
        validator: validator,
        onChanged: onChanged,

        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          fillColor: lighterPurple,
          filled: true,
          hintText: hintText,

          errorStyle: TextStyle(height: 0, backgroundColor: pageBackground, fontSize: 14),
          icon: Icon(icon, color: prefixIcon),
        ),
      ),
    );
  }
} // end StartTxtField


class CustomTextFieldTwo extends StatelessWidget {
  final String    hintText;
  final Function  validator, onChanged;
  final bool      obscureText;
  final TextEditingController controller;
  // Constructor
  const CustomTextFieldTwo({
    Key key,
    this.hintText,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        controller: controller,
        validator: validator,
        onChanged: onChanged,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 5),
          errorStyle: TextStyle(color: red600, fontSize: 14),
          errorBorder: InputBorder.none,
          fillColor: lighterBrown,
          filled: true,
          hintText: hintText,

          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: fullBlack, width: 2 )
            ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: red900,    width: 2 )
            )
        ),  
        maxLines: 5,
        minLines: 3, 
      ),   
    );
  }
} // end CustomTextFieldTwo