
import 'package:flutter/material.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:photo_view/photo_view.dart';

import '../MyColors.dart';

class ProductImageView extends StatelessWidget {
  final String image;
  ProductImageView({this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height:MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              PhotoView(
                backgroundDecoration: BoxDecoration(
                  color: MyColors.white,
                ),
                imageProvider: NetworkImage('$image'),
              ),
              Positioned(
                top:10,
                right:20,
                child: SafeArea(
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Text("close",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                          ),),SizedBox(width: 5,),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(Icons.close,color: MyColors.white,size:15),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );

  }
}

