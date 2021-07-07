import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';

class CommentsForm extends StatelessWidget {
  final String comment;
  const CommentsForm({this.comment});

  @override
  Widget build(BuildContext context) {
    const _textStyle = TextStyle(fontSize: 20, color: fullBlack, fontFamily: 'inconsolata');
    List<String> splitComments=[];
    if (comment.contains(RegExp(r'[a-z]'))){
      splitComments = comment.split(',').toList();
    }else{
      String empty = 'No Comments Present';
      splitComments = empty as List<String>;
    }

    if(splitComments.length < 3){
      splitComments.add(" ");
      splitComments.add(" ");
    }

        return Column(
          children: [
            SizedBox(height: 25),
            Text('${splitComments[0]}', style: _textStyle),
              SizedBox(height: 5),
            Text('${splitComments[1]}', style: _textStyle),
              SizedBox(height: 5),
            Text('${splitComments[2]}', style: _textStyle),
          ]
            );
  }
}