import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/contants.dart';
import 'package:shose_app/screens/cart_page.dart';
import 'package:shose_app/services/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasbackArrow;
  final bool hasTitle;
  final bool hasBackground;
  CustomActionBar({this.title,this.hasbackArrow,this.hasTitle,this.hasBackground});
  @override
  Widget build(BuildContext context) {
    FirebaseServices _firebaseServices=FirebaseServices();
    bool _hasBackArrow=hasbackArrow??false;
    bool _hasTitle=hasTitle??true;
    bool _hasBackground=hasBackground??true;
    final CollectionReference _userRef=FirebaseFirestore.instance.collection("Users");
    return Container(
      decoration: BoxDecoration(
        gradient:_hasBackground? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0)
          ],
          begin: Alignment(0,0),
          end:Alignment(0,1),
        ):null
      ),
    padding: EdgeInsets.only(
      top:56.0,
      left: 24.0,
      right: 24.0,
      bottom: 42.0
    ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          if(_hasBackArrow)
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child:Image(
                  image: AssetImage(
                    "assets/images/noun_back_1213628.png"
                  ),
                ),
              ),
            ),
          if(_hasTitle)
            Text(
              title??"Action Bar",
              style: Constants.regularHeading,
            ),//Tiêu đề
          //ĐIều hướng đến page cart
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>CartPage(),
              ),
              );
            },
            //Số lượng trong giỏ
            child: Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _userRef.doc(_firebaseServices.getUserid()).collection("cart").snapshots(),
                builder: (context,snapshot){
                  int _totalitems=0;
                  if(snapshot.connectionState==ConnectionState.active){
                    List _documents=snapshot.data.docs;
                    _totalitems=_documents.length;
                  }
                  return Text(
                    "${_totalitems}"??"0",
                    style:TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color:Colors.white,
                    ),
                  );//Số lượng trong giỏ
                },
              )
            ),
          ),

        ],
      ),
    );
  }
}
