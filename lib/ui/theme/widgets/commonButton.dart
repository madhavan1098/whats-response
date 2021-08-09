



import 'package:flutter/material.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/commonStyles.dart';

class CommonButton extends StatefulWidget {
  final Widget child;
  final Function onPressed;
  final double width;
  final double height;
  final double borderRadius;
  final double verticalPadding;
  final String text;
  final bool fullWidth;
  final bool showLoader;
  final bool tapDissabled;
  CommonButton({this.tapDissabled=false,this.showLoader=false,this.fullWidth=true,this.text="",this.verticalPadding=15,this.child,this.onPressed,this.width,this.height,this.borderRadius=8});

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    widget.onPressed();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown:widget.tapDissabled || widget.showLoader ? null : _onTapDown,
      onTapUp:widget.tapDissabled || widget.showLoader ? null :_onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:15.0,vertical: widget.verticalPadding),
          child: Container(
            height:  widget.height==null?
            widget.fullWidth==false?45:55: widget.height,
            width:  widget.width==null?null: widget.width,
            decoration: BoxDecoration(
                color: !widget.tapDissabled ? MyColors.primaryColor : MyColors.grey.withAlpha(80),
                borderRadius: BorderRadius.circular( widget.borderRadius)
            ),
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: widget.fullWidth==true?MainAxisSize.max:MainAxisSize.min,
                children: [
                !widget.showLoader?  Text("${widget.text}",
                    style: kCommonTextWhite ):
                    // TextStyle(
                    //     color: MyColors.white,
                    //     fontWeight: widget.height==null?
                    //     widget.fullWidth==false?FontWeight.w600:FontWeight.w600: widget.height<50?FontWeight.normal:FontWeight.bold,
                    //     fontSize:
                    //     widget.height==null?
                    //     widget.fullWidth==false?16:17: widget.height<50?14:17
                    // ),)
                    SizedBox(
                    width: 25,
                    height: 25,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:new AlwaysStoppedAnimation<Color>(MyColors.white),
                      ),
                    ),
                  ),
                  // SizedBox(width: 10,),
                  // Icon(Icons.arrow_forward,color: MyColors.white,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}