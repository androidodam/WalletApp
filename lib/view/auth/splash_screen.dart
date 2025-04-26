import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/assets.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/navigator.dart';
import 'package:flutter_wallet_app_lesson56/view/onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000)).then((value) {
      pushToReplace(Onboarding(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);
    return Scaffold(
      backgroundColor: tema.canvasColor,
      body: Center(
        child: SvgPicture.asset(Assets.icon.textLogo),
      ),
    );
  }
}
