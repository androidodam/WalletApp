import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/export.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/translate.dart';
import 'package:flutter_wallet_app_lesson56/view/home/home_screen.dart';
import 'package:flutter_wallet_app_lesson56/view/profile_screen.dart';
import 'package:flutter_wallet_app_lesson56/view/request_screen.dart';
import 'package:flutter_wallet_app_lesson56/view/send_screen.dart';

class BnbPage extends StatefulWidget {
  const BnbPage({super.key});

  @override
  State<BnbPage> createState() => _BnbPageState();
}

class _BnbPageState extends State<BnbPage> {
  int selectedIndex = 0;
  List pages = [
    HomeScreen(),
    SendScreen(),
    RequestScreen(),
    ProfileScreen(),
  ];

  List imageItem = [
    Assets.icon.home,
    Assets.icon.send,
    Assets.icon.request,
    Assets.icon.username
  ];

  List<String> getTitleItems(BuildContext context) {
    return [home.tr, expense.tr, request.tr, profile.tr];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        width: 1.sw(context),
        height: 110.h,
        decoration: BoxDecoration(
          color: tema.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.grey.withValues(alpha: 0.3),
              blurRadius: 7,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Container(
          width: 0.8.sw(context),
          height: 75.h,
          margin: EdgeInsets.all(16.o),
          decoration: BoxDecoration(
            color: tema.focusColor,
            borderRadius: BorderRadius.circular(15.o),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              pages.length,
              (index) {
                return Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      icon: SvgPicture.asset(
                        imageItem[index],
                        color: selectedIndex == index
                            ? tema.cardColor
                            : theme.grey.withValues(alpha: 0.6),
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Text(
                      getTitleItems(context)[index],
                      style: theme.testStyle.copyWith(
                          fontSize: 12.o,
                          color: selectedIndex == index
                              ? tema.cardColor
                              : theme.grey.withValues(alpha: 0.6)),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
