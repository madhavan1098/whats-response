

  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';

import 'commonCircularLoading.dart';
import 'imagePreview.dart';

class LoadImage extends StatelessWidget {
  final String image;
  final bool disableClick;
  final BoxFit fit;
  LoadImage({@required this.image,this.fit=BoxFit.fill,this.disableClick=false});
    @override
    Widget build(BuildContext context) {
      return
        AbsorbPointer(
          absorbing: disableClick==false?false:true,
        child:InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductImageView(image:image)),
          );

        },
        child: CachedNetworkImage(
            imageUrl: "$image",
          fit: fit,
          errorWidget:  (context, url, error) =>
              Padding(
                padding: const EdgeInsets.only(top:0.0),
                child: Icon(Icons.person, color: Colors.grey,size: 50,),
                // Image.asset("assets/images/noImagePlaceholder.png",
                //   fit:fit,),
              ),
          placeholder: (context, url) =>  LoadingWidget(
            center: true,
          )
          ),
      ));
    }
  }









