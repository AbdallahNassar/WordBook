import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
//==========================================================================
    return Container(
      padding: EdgeInsets.only(
        top: _mediaQuery.size.height * 0.009,
        bottom: _mediaQuery.size.height * 0.009,
        right: _mediaQuery.size.height * 0.013,
      ),
      alignment: Alignment.bottomLeft,
      height: _mediaQuery.size.height * 0.115,
      child: PlatformIconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(
          PlatformIcons(context).back,
          size: 30,
          color: Color(0xFFFF9D80),
        ),
        onPressed: () =>
            Navigator.of(context).canPop() ? Navigator.of(context).pop() : {},
      ),
    );
  }
}
