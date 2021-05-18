import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/widgets/custom_btn.dart';
import 'package:shose_app/widgets/custom_input.dart';

import '../contants.dart';

class RegisterPageState extends StatefulWidget {
  @override
  _RegisterPageStateState createState() => _RegisterPageStateState();
}

class _RegisterPageStateState extends State<RegisterPageState> {
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Lỗi!"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                   child: Text("Đóng"),
                   onPressed: (){
                     Navigator.pop(context);
                   },
              )

            ],
          );
        }
    );
  }
  //Ánh xạ
  String _rsEmail="";
  String _rsPassword="";
  //Hàm tạo tk
  Future<String> _createAccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _rsEmail, password: _rsPassword);
      return null;
      }on FirebaseAuthException catch(e){
        if (e.code == 'weak-password') {
          return 'Mật khẩu yếu!';
      } else if (e.code == 'email-already-in-use') {
            return 'Email này đã được sử dụng rồi!';
      }
        return e.message;
    } catch(e){
      return e.toString();
    }
  }
  //Hàm gửi
  void _submitForm() async{
    setState(() {
      _registerFormLoading=true;
    });
    String _createAccountFeedback= await _createAccount();
    if(_createAccountFeedback!=null)
      {
        _alertDialogBuilder(_createAccountFeedback);
        setState(() {
          _registerFormLoading=false;
        });
      }
    else{
      Navigator.pop(context);
    }
  }
  //Loading
  bool _registerFormLoading=false;
  FocusNode _passwordFocusNode;
  @override
  void initState(){
    _passwordFocusNode=FocusNode();
    super.initState();
  }
  @override
  void dispose(){
    _passwordFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Container(
                padding:EdgeInsets.only(
                  top:24.0,
                ),
                child:Text(
                  "Đăng ký",
                  textAlign: TextAlign.center,
                  style: Constants.boldheading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email...",
                    onChanged: (value){
                      _rsEmail=value;
                    },
                    onSubmit: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textinputAction: TextInputAction.next,
                  ),//Emailinput
                  CustomInput(
                    hintText: "Password...",
                    onChanged: (value){
                      _rsPassword=value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmit: (value){
                      _submitForm();
                    },

                  ),//passwwordinput
                  Custombtn(
                    text: "Đăng ký",
                    onPressed: (){
                      _submitForm();
                    },
                    isLoading: _registerFormLoading,
                    outlienbtn: false,
                  ),//btnSubmit
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom:15.0,
                ),
                child:Custombtn(
                  text: "Quay lại trang đăng nhập",
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  outlienbtn: true,
                ),//btnBack
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
