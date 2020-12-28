import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SomethingWentWrong extends StatelessWidget {
  //================================ Parameters ================================
  final String message;
  //================================ Constructor ===============================
  const SomethingWentWrong({
    Key key,
    this.message = 'Please try again.',
  }) : super(key: key);
  //============================================================================

  @override
  Widget build(BuildContext context) {
//================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
//==========================================================================
    return Container(
      height: _mediaQuery.size.height * 0.7,
      width: _mediaQuery.size.width * 0.8,
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/error_2.svg',
            height: _mediaQuery.size.height * 0.4,
          ),
          Text(
            'Something Went Wrong.\n$message',
            textAlign: TextAlign.center,
            style: Platform.isAndroid
                ? Theme.of(context).textTheme.button.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    )
                : CupertinoTheme.of(context)
                    .textTheme
                    .tabLabelTextStyle
                    .copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
          ),
        ],
      ),
    );
  }
}
