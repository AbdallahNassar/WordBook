import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataText extends StatelessWidget {
  const NoDataText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'No Available Data.',
      style: Platform.isAndroid
          ? Theme.of(context).textTheme.button.copyWith(
                fontSize: 15.0,
              )
          : CupertinoTheme.of(context).textTheme.tabLabelTextStyle.copyWith(
                fontSize: 15.0,
              ),
    );
  }
}
