import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/screens/register_page.dart';
import 'package:shose_app/widgets/custom_btn.dart';
import 'package:shose_app/widgets/custom_input.dart';

import '../contants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Error!"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: (){
                  Navigator.pop(context);
                },
              )

            ],
          );
        }
    );
  }
  //Value
  String _lgEmail="";
  String _lgPassword="";
  //Create a new usser Account
  Future<String> loginAccount() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _lgEmail, password: _lgPassword);
      return null;
    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    } catch(e){
      return e.toString();
    }
  }
  void _submitForm() async{
    setState(() {
      _loginFormLoading=true;
    });
    String _loginFeedBack= await loginAccount();
    if(_loginFeedBack!=null)
    {
      _alertDialogBuilder(_loginFeedBack);
      setState(() {
        _loginFormLoading=false;
      });
    }

  }
  //Loading
  bool _loginFormLoading=false;


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
                  "Đăng nhập",
                   textAlign: TextAlign.center,
                   style: Constants.boldheading,
                    ),//login
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email...",
                    onChanged: (value){
                      _lgEmail=value;
                    },
                    onSubmit: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textinputAction: TextInputAction.next,
                  ),//Email
                  CustomInput(
                    hintText: "Mật khẩu...",
                    onChanged: (value){
                      _lgPassword=value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmit: (value){
                      _submitForm();
                    },
                  ),//Password
                  Custombtn(
                    text: "Đăng nhập",
                    onPressed: (){
                      _submitForm();
                    },
                    isLoading: _loginFormLoading,

                    outlienbtn: false,
                  ),//btnLogin

                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(
                  bottom:15.0,
                  ),
                child:Custombtn(
                  text: "Đăng ký",
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>RegisterPageState()
                        ),
                    );
                  },
                  outlienbtn: true,
                ),//BtnResign
                ),
                ],
      ),
      ),
      ),
    );
  }
}
