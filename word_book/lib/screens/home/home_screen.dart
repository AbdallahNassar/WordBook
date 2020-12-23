import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../helpers/gradient_helper.dart';
import './components/home_container.dart';

class HomeScreen extends StatelessWidget {
  //================================ Parameters ================================
  static const String routeName = '/home';
  //================================ Constructor ===============================
  const HomeScreen({
    Key key,
  }) : super(key: key);
  //============================================================================

  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return Scaffold(
      body: Container(
        height: _mediaQuery.size.height,
        width: _mediaQuery.size.width,
        decoration: BoxDecoration(gradient: GradientHelper.linearGradient),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: _mediaQuery.orientation == Orientation.landscape
                    ? _mediaQuery.size.height * 0.05
                    : _mediaQuery.size.height * 0.12,
              ),
              PlatformText(
                'Word Book',
                style: Platform.isIOS
                    ? CupertinoTheme.of(context)
                        .textTheme
                        .navLargeTitleTextStyle
                    : Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: _mediaQuery.orientation == Orientation.landscape
                    ? _mediaQuery.size.height * 0.05
                    : _mediaQuery.size.height * 0.08,
              ),
              HomeContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
