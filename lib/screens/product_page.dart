import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/contants.dart';
import 'package:shose_app/services/firebase_services.dart';
import 'package:shose_app/widgets/custom_action_bar.dart';
import 'package:shose_app/widgets/image_swipe.dart';
import 'package:shose_app/widgets/product_size.dart';

class ProductPage extends StatefulWidget {
  final String productid;
  ProductPage({this.productid});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices=FirebaseServices();
  String _selectedProductSize="0";
  //Thêm vào giỏ hàng
  Future _addToCart(){
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserid())
        .collection("cart")
        .doc(widget.productid).set(
    {
      "size":_selectedProductSize
    }
    );
  }
  //Thêm vào đã lưu
  Future _addToSaved() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserid())
        .collection("Saved")
        .doc(widget.productid)
        .set({"size": _selectedProductSize});
  }
  final SnackBar _snackBar=SnackBar(content: Text("Đã thêm vào giỏ hàng"));
  final SnackBar _snackBar1=SnackBar(content: Text("Đã lưu"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          FutureBuilder(
              future: _firebaseServices.productRef.doc(widget.productid).get(),
            builder: (context,snapshot){
                //Check Lỗi
                if(snapshot.hasError){
                  return Scaffold(
                    body:Center(
                      child: Text("Lỗi : ${snapshot.error}"),
                    )
                  );
                }
                //Lấy đc data
                if(snapshot.connectionState==ConnectionState.done)
                  {
                    Map<String,dynamic> documentData=snapshot.data.data();
                    List imageList=documentData['images'];
                    List productSizes=documentData['size'];
                    _selectedProductSize="${productSizes[0]}";
                    return ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        ImageSwipe(imageList: imageList,),//List ẢNh
                        Padding(
                          padding: const EdgeInsets.only(
                            top:24.0,
                            left:24.0,
                            right: 24.0,
                            bottom: 4.0,
                          ),
                          child: Text(
                              "${documentData['name']}"??"Product Name",
                            style:TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),//Truyền tên sp
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "${documentData['price']}VNĐ"??"Price",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),//Giá sản phẩm
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "${documentData['desc']}"??"Dessc",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),

                          ),//Mô tả
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24.0,
                            horizontal: 24.0,
                          ),
                          child: Text(
                              "Chọn Size",
                            style: Constants.regularDarkText,
                          ),//Size
                        ),
                        ProdutcSize(
                          productSizes: productSizes,
                          onSelected: (size){
                            _selectedProductSize="${size}";
                          },
                        ),//Box chọn size

                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:() async{
                                  await _addToSaved();
                                  Scaffold.of(context).showSnackBar(_snackBar1);
                                },
                                child: Container(
                                  width:60.0,
                                  height:60.0,
                                  decoration:BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment:Alignment.center,
                                  child: Image(
                                    image:AssetImage(
                                      "assets/images/noun_Save_3460469.png"
                                    ),
                                    width: 28.0,
                                  )
                                ),
                              ),//Nút Lưu
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async{
                                    await _addToCart();
                                    Scaffold.of(context).showSnackBar(_snackBar);
                                },
                                  child: Container(
                                    height: 60.0,
                                    margin: EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                        "Thêm vào giỏ hàng",
                                      style:TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),//Nút thêm vào giỏ hàng
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                //Loading....
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),

                  ),
                );
            },
          ),

          CustomActionBar(
            hasbackArrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      )
    );
  }
}
