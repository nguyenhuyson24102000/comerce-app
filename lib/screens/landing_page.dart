import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/screens/home_page.dart';
import 'package:shose_app/screens/login_page.dart';
import '../contants.dart';
import "package:firebase_auth/firebase_auth.dart";

class LandingPage extends StatelessWidget{
  final Future<FirebaseApp> _inittalization=Firebase.initializeApp();
  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
        future: _inittalization,
        builder: (context,snapshot){
          if(snapshot.hasError)
          {
            return Scaffold(
                body:Center(
                  child: Text("Lỗi:${snapshot.error}"),
                )
            );
          }
          //Check Connect Internet
          if(snapshot.connectionState==ConnectionState.done)
          {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder:(context,streamsnapshot){
                if(streamsnapshot.hasError)
                {
                  return Scaffold(
                      body:Center(
                        child: Text("Lỗi:${streamsnapshot.error}"),
                      )
                  );
                }
                if(streamsnapshot.connectionState==ConnectionState.active)
                {
                  User user=streamsnapshot.data;
                  if(user==null)
                  {
                    return LoginPage();
                  }else{
                    return HomePage();
                  }
                }
                //Loading....
                return Scaffold(
                  body:Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            );
          }
          return Scaffold(
            body:Center(
              child:Text("Không có kết nối Internet..:", style:Constants.regularHeading,) ,
            ),
          );
        }
    );
  }
}


