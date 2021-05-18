import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/contants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;

  final Function(String) onChanged;
  final Function(String) onSubmit;
  final FocusNode focusNode;
  final TextInputAction textinputAction;
  final bool isPasswordField;
  CustomInput({this.hintText,this.onChanged,this.onSubmit,this.focusNode,this.textinputAction,this.isPasswordField});
  @override
  Widget build(BuildContext context) {
    bool _isspasswwordfile=isPasswordField?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: TextField(
        obscureText: _isspasswwordfile,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmit,
        textInputAction: textinputAction,
        decoration: InputDecoration(
          border:InputBorder.none,
          hintText: hintText??"Input Text",
            contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
             vertical: 20.0,
        )
        ),
        style:Constants.regularDarkText ,
      ),
    );
  }
}
