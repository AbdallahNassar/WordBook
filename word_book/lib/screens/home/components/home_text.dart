import 'package:flutter/material.dart';

import '../../../helpers/gradient_helper.dart';

class HomeText extends StatelessWidget {
  //================================ Parameters ================================
  final String widgetText;
  //================================ Constructor ==============================
  const HomeText({
    Key key,
    this.widgetText,
  }) : super(key: key);
  //============================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return Padding(
      padding: EdgeInsets.only(
        top: _mediaQuery.size.height * 0.03,
        bottom: _mediaQuery.size.height * 0.004,
      ),
      child: Text(
        widgetText,
        style: GradientHelper.mGetSearchCardTextStyle(
          context,
          _mediaQuery.size.width * 0.7,
          _mediaQuery.size.height * 0.01,
        ).copyWith(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
