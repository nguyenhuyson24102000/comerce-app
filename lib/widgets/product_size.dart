import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProdutcSize extends StatefulWidget {
  final List productSizes;
  final Function(String) onSelected;

  ProdutcSize({this.productSizes,this.onSelected});
  @override
  _ProdutcSizeState createState() => _ProdutcSizeState();
}

class _ProdutcSizeState extends State<ProdutcSize> {
  int _Selected=0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        20.0,
      ),
      child: Row(
        children:[
          for(var i=0;i<widget.productSizes.length;i++)
            GestureDetector(
              onTap: (){
                widget.onSelected("${widget.productSizes[i]}");
                setState(() {
                  _Selected=i;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left:5.0),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color:_Selected==i?Theme.of(context).accentColor:Color(0XFFDCDCDC),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${widget.productSizes[i]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color:_Selected==i?Colors.white: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            )
        ]
      ),
    );
  }
}
