import 'package:flutter/material.dart';

class WhiteContainer extends StatelessWidget {
  //================================ Parameters ================================
  final Widget child;
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry padding;

  //================================ Constructor ===============================
  const WhiteContainer({
    Key key,
    @required this.child,
    @required this.height,
    this.width,
    this.constraints,
    this.margin,
    this.padding,
  }) : super(key: key);
  //============================================================================

  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return Container(
      constraints: constraints,
      padding: padding,
      // to check whether this is the home container or not.
      margin: margin != null
          ? margin
          : width == _mediaQuery.size.width * 0.8
              ? EdgeInsets.all(
                  0.0,
                )
              : EdgeInsets.symmetric(
                  horizontal: _mediaQuery.size.width * 0.01,
                  vertical: _mediaQuery.size.height * 0.004,
                ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(
          25.0,
        ),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
