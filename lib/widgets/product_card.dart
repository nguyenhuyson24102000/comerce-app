

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shose_app/screens/product_page.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  ProductCard({this.productId,this.onPressed,this.imageUrl,this.title,this.price});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ProductPage(productid:productId ,)
        ));
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          height: 350.0,
          margin: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 24.0,
          ),
          child: Stack(
            children:[
              Container(
                height:350.0,
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(12.0),
                  child: Image.network(
                    "${imageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),//Image
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${title}",
                        style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600
                            ,color:Colors.black
                        ),
                      ),
                      Text(
                       price,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600
                        ),),
                    ],
                  ),
                ),
              )
            ],
          )

      ),
    );
  }
}
