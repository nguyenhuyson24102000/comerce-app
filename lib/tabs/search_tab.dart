import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/services/firebase_services.dart';
import 'package:shose_app/widgets/custom_input.dart';
import 'package:shose_app/widgets/product_card.dart';

import '../contants.dart';
class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "......",
                  style: Constants.regularDarkText,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productRef.where('name',isEqualTo: '${_searchString}').get(),
              builder: (context, snapshot) {
                //check Error
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Lỗi: ${snapshot.error}"),
                    ),
                  );
                }
                // Dữ liệu tìm kiếm
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 128.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) { 
                      return ProductCard(
                        title: document.data()['name'],
                        imageUrl: document.data()['images'][0],
                        price: "${document.data()['price']}VNĐ",
                        productId: document.id,
                      );
                    }).toList(),
                  );
                }

                // Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: CustomInput(
              hintText: "Nhập tên giày càn tìm...",
              onSubmit: (value) {
                setState(() {
                  _searchString = value;
                });

              },
            ),
          ),
        ],
      ),
    );
  }
}
