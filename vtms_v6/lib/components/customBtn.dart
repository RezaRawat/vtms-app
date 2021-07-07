import 'package:flutter/material.dart';

class FormatButton extends StatelessWidget {
  final String    text;
  final Function  onPressed;
  final Color     color, textColor;
  final double    buttonWidth, fontSize;
  // Constructor
  const FormatButton({
    Key key,
    this.text,
    this.onPressed,
    this.color,
    this.fontSize,
    this.textColor,
    this.buttonWidth  
  }): super(key : key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: size.width * buttonWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        // ignore: deprecated_member_use
        child: RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            color: color,
            textColor: textColor,
            onPressed: onPressed,
            child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
        ),
      ),
      
    );
  }
}

class ButtonExtra extends StatelessWidget {
  final String    text;
  final Function  onPressed;
  final Color     color, textColor, borderColor;
  final double    bWidth, bHeight, fontSize;
  const ButtonExtra({
    Key key,
    this.text,
    this.onPressed,
    this.color,
    this.fontSize,
    this.textColor,
    this.bWidth,
    this.bHeight,  
    this.borderColor
  }): super(key : key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return ButtonTheme(
      minWidth: bWidth,
      height: bHeight,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: color,
        textColor: textColor,
        shape: StadiumBorder(
          side: BorderSide(color: borderColor, width: 2)),
          onPressed: onPressed,
          child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
      ),
    );
  }
}

class IconButtonY extends StatelessWidget {
  final String    text;
  final Function  onPressed;
  final Icon icon;
  final Color     color, textColor, borderColor;
  final double    bWidth, bHeight, fontSize;
  const IconButtonY({
    Key key,
    this.text,
    this.icon,
    this.onPressed,
    this.color,
    this.fontSize,
    this.textColor,
    this.bWidth,
    this.bHeight,  
    this.borderColor
  }): super(key : key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: bWidth,
      height: bHeight,
      // ignore: deprecated_member_use
      child: RaisedButton.icon(
        icon: icon,
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(8.0)),
          onPressed: onPressed,
          label: Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
        ), 
    );
  }
}

