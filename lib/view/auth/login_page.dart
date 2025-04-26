import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wallet_app_lesson56/common/components/custom_button.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/export.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/status.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/translate.dart';
import 'package:flutter_wallet_app_lesson56/main.dart';
import 'package:flutter_wallet_app_lesson56/view/bnb/bnb.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  TextEditingController _nameController = TextEditingController();

  Future<void> _getName() async {
    final pickedInfo = await _nameController.text;
    if (pickedInfo.isNotEmpty) {
      pref.setString("userName", "$pickedInfo");
    }
  }

  Future<void> _loginUser() async {
    await _getName();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_loged_in", true);
    pushToUntil(BnbPage(), context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          width: 1.sw(context),
          height: 1.sh(context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                tema.brightness == Brightness.light
                    ? Assets.image.loginLight
                    : Assets.image.loginDark,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  userImage.tr,
                  style: theme.testStyle.copyWith(
                    fontSize: 14.o,
                    fontWeight: FontWeight.w500,
                    color: theme.blue,
                  ),
                ),
              ),
              30.gapY,
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: name.tr,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.greyAccent, width: 1.o),
                    borderRadius: BorderRadius.circular(10.o),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.o),
                    borderSide: BorderSide(color: theme.greyAccent, width: 1.o),
                  ),
                ),
              ),
              28.gapY,
              CustomButton(
                onTap: () {
                  _loginUser();
                  _getName();
                  pushToUntil(BnbPage(), context);
                },
                status: CustomButtonStatus.ELEVETED,
                title: login.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
