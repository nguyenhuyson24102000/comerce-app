import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/contants.dart';
import 'package:shose_app/screens/product_page.dart';
import 'package:shose_app/widgets/custom_action_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shose_app/widgets/product_card.dart';
class HomeTab extends StatelessWidget {
  final CollectionReference _productRef=FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
         FutureBuilder<QuerySnapshot>(
           future: _productRef.get(),
           builder: (context,snapshot) {
             if (snapshot.hasError) {
               return Scaffold(
                 body: Center(
                   child: Text("Lỗi : ${snapshot.error}"),
                 ),
               );
             }
               if(snapshot.connectionState==ConnectionState.done)
                 {
                   return ListView(
                     padding: EdgeInsets.only(
                       top:108.0,
                       bottom:12.0,
                     ),
                     children:snapshot.data.docs.map((document){
                       return ProductCard(
                         title: document.data()['name'],
                         imageUrl: document.data()['images'][0],
                         price: "${document.data()['price']}VNĐ",
                         productId: document.id,
                         onPressed: (){
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context)=>ProductPage(productid: document.id,)
                               ),
                           );
                         },

                       );
                     }).toList(),

                   );
                 }

             return Scaffold(
               body: Center(
                 child: CircularProgressIndicator(),
               ),
             );
           }
         ),

         CustomActionBar(
           title:"Trang Chủ",
           hasTitle: true,
           hasbackArrow: false,
         )

        ],
      ),
    );
  }
}
