import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallet_app_lesson56/common/components/custom_button.dart';
import 'package:flutter_wallet_app_lesson56/common/components/custom_text_filed.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/export.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/status.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/translate.dart';
import 'package:flutter_wallet_app_lesson56/models/expens_model.dart';
import 'package:flutter_wallet_app_lesson56/view_model/expens_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SendScreen extends ConsumerStatefulWidget {
  const SendScreen({super.key});

  @override
  ConsumerState<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends ConsumerState<SendScreen> {
  DateTime _selectedTime = DateTime.now();
  Future<void> _selectedDateTime(BuildContext context) async {
    final DateTime? picedDate = await showDatePicker(
      initialDate: _selectedTime,
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picedDate != null) {
      final TimeOfDay? picedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedTime),
      );
      if (picedTime != null) {
        setState(() {
          _selectedTime = DateTime(
            picedDate.year,
            picedDate.month,
            picedDate.day,
            picedTime.hour,
            picedTime.minute,
          );
        });
      }
    }
  }

  final picker = ImagePicker();
  File? _sendImage;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _summaController = TextEditingController();

  void _saveExpense() {
    if (_nameController.text.isEmpty || _summaController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${snackBarAlert.tr}!")));
      return;
    }
    final newExpense = ExpensModel(
      id: UniqueKey().toString(),
      title: _nameController.text,
      image: _sendImage?.path,
      sana: _selectedTime,
      price: double.parse(_summaController.text),
      isPrice: false,
    );
    ref.read(expensProvider).addExpense(newExpense);

    _nameController.clear();
    _summaController.clear();
    _sendImage = null;
    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(sentAded.tr)));
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxHeight: 1024,
        maxWidth: 1024);

    if (pickedFile != null) {
      _sendImage = File(pickedFile.path);
      setState(() {});
    }
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
                sent.tr,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.o, vertical: 10.o),
              child: Column(
                children: [
                  Container(
                    alignment: _sendImage == null ? Alignment.center : null,
                    clipBehavior: Clip.hardEdge,
                    width: 100.o,
                    height: 100.o,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.o),
                        color: theme.greyAccent2),
                    child: _sendImage != null
                        ? Image.file(
                            File("${_sendImage!.path}"),
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
                      sentImage.tr,
                      style: theme.testStyle.copyWith(
                        fontSize: 14.o,
                        fontWeight: FontWeight.w500,
                        color: theme.blue,
                        fontFamily: theme.fontAbys,
                      ),
                    ),
                  ),
                  40.o.gapY,
                  CustomTextFiled(
                    label: sentName.tr,
                    controller: _nameController,
                    borderColor: theme.yellow,
                    keyboardType: "text",
                  ),
                  30.o.gapY,
                  CustomTextFiled(
                    label: sentSumma.tr,
                    controller: _summaController,
                    borderColor: theme.yellow,
                    keyboardType: "number",
                  ),
                  20.o.gapY,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          _selectedDateTime(context);
                        },
                        child: Text(
                          dateTime.tr,
                          style: theme.testStyle.copyWith(
                            color: tema.primaryColorDark,
                            fontFamily: theme.fontAbys,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "${DateFormat("MMM dd, h:mm a").format(_selectedTime)}",
                        style: theme.testStyle.copyWith(
                          color: tema.primaryColorDark,
                          fontFamily: theme.fontAbys,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  22.o.gapY,
                  CustomButton(
                    onTap: () {
                      _saveExpense();
                    },
                    icon: Assets.icon.send,
                    title: save.tr,
                    backgroundColor: theme.yellow,
                    textColor: theme.black,
                    status: CustomButtonStatus.ELEVETED,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
