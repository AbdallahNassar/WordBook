import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../helpers/gradient_helper.dart';

class NextArrow extends StatelessWidget {
  //================================ Parameters ================================
  final Function functionHandler;
  final Icon icon;
  //================================ Constructor ===============================
  const NextArrow({
    Key key,
    @required this.icon,
    @required this.functionHandler,
  }) : super(key: key);
  //============================================================================

  @override
  Widget build(BuildContext context) {
    //================================ Parameters ================================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //============================================================================
    return Container(
      alignment: Alignment.centerRight,
      // to change the orientation of the arrow (icon)
      child: RotatedBox(
        quarterTurns: 1,
        // shader mask to give a gradient to the icon
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (_) => GradientHelper.mGetShader(
            context,
            _mediaQuery.size.width * 0.1,
            _mediaQuery.size.height * 0.01,
          ),
          child: PlatformIconButton(
            onPressed: functionHandler,
            icon: icon
          ),
        ),
      ),
    );
  }
}
