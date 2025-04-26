import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/export.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/keys.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/translate.dart';
import 'package:flutter_wallet_app_lesson56/main.dart';
import 'package:flutter_wallet_app_lesson56/view_model/theme_provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isTheme = false;
  @override
  void initState() {
    isTheme = pref.getString("theme") == "light" ? true : false;
    super.initState();
  }

  final picker = ImagePicker();
  File? _image;

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxHeight: 1024,
        maxWidth: 1024);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      pref.setString("image", _image!.path);
      setState(() {});
    }
  }

  void showModal(BuildContext context, ThemeData tema) {
    final key = pref.getString("language");
    int focus = key == "uz"
        ? 0
        : key == "ru"
            ? 1
            : 2;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(16.o),
              width: 1.sw(context),
              height: 240.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: tema.scaffoldBackgroundColor,
              ),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          focus = index;
                          if (index == 0) {
                            pref.setString("language", "uz");
                            _setLanguage("uz");
                          }
                          if (index == 1) {
                            pref.setString("language", "ru");
                            _setLanguage("ru");
                          }
                          if (index == 2) {
                            pref.setString("language", "en");
                            _setLanguage("en");
                          }
                          pop(context);
                        });
                      },
                      child: _buildLanguage(
                          context,
                          [uz.tr, ru.tr, en.tr][index],
                          [
                            Assets.icon.uzb,
                            Assets.icon.rus,
                            Assets.icon.us,
                          ][index],
                          focus == index),
                    );
                  },
                  separatorBuilder: (context, index) => 16.o.gapY,
                  itemCount: 3),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguage(
      BuildContext context, String lang, String icon, bool isFocus) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.o),
      width: 1.sw(context),
      height: 50.o,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(15.o),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.o),
            child: SvgPicture.asset(
              icon,
              width: 24.o,
              height: 24.o,
            ),
          ),
          10.o.gapx,
          Expanded(
            child: Text(
              lang,
              style: theme.testStyle.copyWith(
                fontSize: 16.o,
                color: theme.white,
              ),
            ),
          ),
          isFocus
              ? Icon(
                  Icons.radio_button_checked,
                  color: theme.blue,
                )
              : Icon(
                  Icons.radio_button_off,
                  color: theme.blue,
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            16.o.gapY,
            Align(
              alignment: Alignment.center,
              child: Text(
                profil.tr,
                style: theme.testStyle.copyWith(
                  fontSize: 20.o,
                  fontWeight: FontWeight.w500,
                  color: tema.primaryColorDark,
                ),
              ),
            ),
            16.o.gapY,
            Divider(
              color: theme.greyAccent2,
              thickness: 2,
            ),
            10.o.gapY,
            Container(
              alignment:
                  pref.getString("image") == null ? Alignment.center : null,
              clipBehavior: Clip.hardEdge,
              width: 100.o,
              height: 100.o,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.o),
                  color: theme.greyAccent2),
              child: pref.getString("image") != null &&
                      pref.getString("image")!.isNotEmpty
                  ? Image.file(
                      File("${pref.getString("image")}"),
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      Assets.icon.user,
                      width: 30.o,
                      height: 30.o,
                    ),
            ),
            5.gapY,
            TextButton(
              onPressed: () {
                _getImage();
              },
              child: Text(
                profileImage.tr,
                style: theme.testStyle.copyWith(
                  fontSize: 14.o,
                  fontWeight: FontWeight.w500,
                  color: theme.blue,
                ),
              ),
            ),
            Card(
              color: tema.scaffoldBackgroundColor,
              elevation: 0,
              child: ListTile(
                leading: SvgPicture.asset(
                  Assets.icon.dark,
                  width: 30.o,
                  height: 30.o,
                  color: tema.primaryColorDark,
                ),
                title: Text(
                  profileTheme.tr,
                  style: theme.testStyle.copyWith(
                    fontSize: 16.o,
                    color: tema.primaryColorDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Switch(
                  activeColor: theme.blue,
                  value: isTheme,
                  onChanged: (value) {
                    setState(() {
                      isTheme = !isTheme;
                      setState(() {
                        themeNotifier.changeTheme(isTheme);
                      });
                    });
                  },
                ),
              ),
            ),
            Card(
              color: tema.scaffoldBackgroundColor,
              elevation: 0,
              child: ListTile(
                onTap: () {
                  showModal(context, tema);
                },
                leading: SvgPicture.asset(
                  Assets.icon.globe,
                  width: 30.o,
                  height: 30.o,
                  color: tema.primaryColorDark,
                ),
                title: Text(
                  profileLanguage.tr,
                  style: theme.testStyle.copyWith(
                    fontSize: 16.o,
                    color: tema.primaryColorDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setLanguage(String language) async {
    lang = language;
    changeLocale(context, language);
    pref.setString("language", language);
  }
}
