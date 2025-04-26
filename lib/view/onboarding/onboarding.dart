import 'package:flutter/material.dart';
import 'package:flutter_wallet_app_lesson56/common/components/custom_button.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/status.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/translate.dart';
import 'package:flutter_wallet_app_lesson56/models/onboarding_model.dart';
import 'package:flutter_wallet_app_lesson56/view/auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../common/helpers/export.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List items = [
    OnboardingModel(
        title: onboardingTitle1.tr, image: Assets.image.onboarding1),
    OnboardingModel(
        title: onboardingTitle2.tr, image: Assets.image.onboarding2),
    OnboardingModel(
        title: onboardingTitle3.tr, image: Assets.image.onboarding3),
  ];
  PageController pageController = PageController();

  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);
    return Scaffold(
      backgroundColor: tema.scaffoldBackgroundColor,
      body: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            isLastPage = items.length - 1 == value;
          });
        },
        controller: pageController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                items[index].image,
                width: 1.sw(context),
                height: 280.h,
                fit: BoxFit.cover,
              ),
              64.gapY,
              Text(
                items[index].title,
                style: theme.testStyle.copyWith(
                  color: tema.primaryColorDark,
                  fontSize: 20.o,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: isLastPage
          ? getStarted(context)
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 5.o),
              width: 1.sw(context),
              height: 100.h,
              color: tema.scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      pushToUntil(LoginPage(), context);
                    },
                    child: Text(
                      skip.tr,
                      style: theme.testStyle.copyWith(
                        fontSize: 16.o,
                        fontWeight: FontWeight.w500,
                        color: theme.blue,
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: items.length,
                    effect: WormEffect(
                      activeDotColor: theme.blue,
                      dotColor: theme.greyAccent,
                      dotHeight: 5.h,
                      dotWidth: 15.w,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text(
                      next.tr,
                      style: theme.testStyle.copyWith(
                        fontSize: 16.o,
                        fontWeight: FontWeight.w500,
                        color: theme.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget getStarted(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
    child: CustomButton(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("onboarding_seen", true);
        pushToReplace(LoginPage(), context);
      },
      status: CustomButtonStatus.ELEVETED,
      title: start.tr,
    ),
  );
}
