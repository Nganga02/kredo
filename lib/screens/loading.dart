import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget logo = SvgPicture.asset(
      'assets/images/logo.svg',
      semanticsLabel: 'Logo',
    );
    return Center(
      child: SizedBox(height: 100, width: 300, child: Center(child: logo)),
    );
  }
}
