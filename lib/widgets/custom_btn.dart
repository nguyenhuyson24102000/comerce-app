import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custombtn extends  StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlienbtn;
  final bool isLoading;
  Custombtn({this.text,this.onPressed,this.outlienbtn,this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outlinebtn=outlienbtn?? false;
    bool _isLoading=isLoading??false;
    return GestureDetector(
     onTap: onPressed,
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlinebtn?Colors.transparent:Colors.black,
          border: Border.all(
            color:Colors.black,
              width:2.0,
          ),
          borderRadius: BorderRadius.circular(12.0,),
        ),
        margin:EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Stack(
          children:[
            Visibility(
              visible: _isLoading? false:true,
              child: Center(
                child: Text(
                text ??"Text",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color:_outlinebtn? Colors.black:Colors.white
                ),
          ),
              ),
            ),
           Visibility(
             visible: _isLoading,
             child: Center(
               child: SizedBox(
                 height: 30.0,
                   width: 30.0,
                 child: CircularProgressIndicator(),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
