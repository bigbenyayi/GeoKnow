import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Flashcard extends StatelessWidget {
  final Widget _child;
  final String _flag;

  const Flashcard({
    super.key,
    required Widget child,
    required String flag,
  })  : _child = child,
        _flag = flag;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 516.0,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black26, blurRadius: 16.0, spreadRadius: 4, offset: Offset(0, 3)),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(32.0)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: SvgPicture.asset(
                _flag,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Container(
          height: 500,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
          ),
          child: Center(
            child: _child,
          ),
        ),
      ],
    );
  }
}
