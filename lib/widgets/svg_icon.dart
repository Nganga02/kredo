// lib/widgets/svg_icon.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final Color? color;
  final String? semanticLabel;

  const SvgIcon({
    Key? key,
    required this.assetPath,
    this.size = 24.0,
    this.color,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        semanticsLabel: semanticLabel,
      ),
    );
  }
}
