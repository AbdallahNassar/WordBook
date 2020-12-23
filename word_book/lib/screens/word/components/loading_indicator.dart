import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: _mediaQuery.size.height * 0.1,
      ),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          Platform.isAndroid
              ? Theme.of(context).primaryColor
              : CupertinoTheme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white54,
      ),
    );
  }
}
