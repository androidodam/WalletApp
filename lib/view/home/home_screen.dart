import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/export.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/translate.dart';
import 'package:flutter_wallet_app_lesson56/main.dart';
import 'package:flutter_wallet_app_lesson56/view_model/expens_provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final totalBalance = ref.watch(expensProvider).totalBalance;
    ThemeData tema = Theme.of(context);
    return Consumer(
      builder: (context, ref, child) {
        final expensList = ref.watch(expensProvider).list;

        final incomeSum = expensList
            .where((kirim) => kirim.isPrice)
            .fold(0.0, (sum, kirim) => sum + kirim.price);

        final expenseSum = expensList
            .where((expense) => !expense.isPrice)
            .fold(0.0, (sum, expense) => sum + expense.price);

        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 20.o, right: 20.o, top: 45.o, bottom: 10.o),
              width: 1.sw(context),
              height: 270.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.image.homebg), fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        panel.tr,
                        style: theme.testStyle.copyWith(
                          fontSize: 20.o,
                          fontWeight: FontWeight.w500,
                          color: theme.white,
                        ),
                      ),
                      Container(
                        alignment: pref.getString("image") == null
                            ? Alignment.center
                            : null,
                        clipBehavior: Clip.hardEdge,
                        width: 70.o,
                        height: 70.o,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.o),
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
                    ],
                  ),
                  Text(
                    "${hello.tr}! ${pref.getString("userName") ?? "User"}",
                    style: theme.testStyle.copyWith(
                      color: theme.white.withValues(alpha: 0.7),
                      fontSize: 16.o,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  5.gapY,
                  Text(
                    balance.tr,
                    style: theme.testStyle.copyWith(
                      color: theme.white,
                      fontSize: 20.o,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${totalBalance.toStringAsFixed(0)} ${sum.tr}",
                    style: theme.testStyle.copyWith(
                      color: theme.white,
                      fontSize: 40.o,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        recentTr.tr,
                        style: theme.testStyle.copyWith(
                          fontSize: 16.o,
                          fontWeight: FontWeight.bold,
                          color: tema.primaryColorDark,
                        ),
                      ),
                    ),
                    16.o.gapY,
                    Container(
                      width: 1.sw(context),
                      height: 70.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 0.45.sw(context),
                            height: 70.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  expenses.tr,
                                  style: theme.testStyle.copyWith(
                                    fontSize: 18.o,
                                    fontWeight: FontWeight.w600,
                                    color: tema.primaryColorDark,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12.o),
                                  ),
                                  child: Text(
                                    expenseSum == 0
                                        ? "0"
                                        : "-${expenseSum.toStringAsFixed(0)}",
                                    style: theme.testStyle.copyWith(
                                      fontSize: 18.o,
                                      fontWeight: FontWeight.w600,
                                      color: theme.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.45.sw(context),
                            height: 70.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  requests.tr,
                                  style: theme.testStyle.copyWith(
                                    fontSize: 18.o,
                                    fontWeight: FontWeight.w600,
                                    color: tema.primaryColorDark,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12.o),
                                  ),
                                  child: Text(
                                    incomeSum == 0
                                        ? "0"
                                        : "+${incomeSum.toStringAsFixed(0)}",
                                    style: theme.testStyle.copyWith(
                                      fontSize: 18.o,
                                      fontWeight: FontWeight.w600,
                                      color: theme.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.o.gapY,
                    Flexible(
                        child: expensList.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(Assets.image.empty),
                                    16.o.gapY,
                                    Text(
                                      "${noTransactions.tr}!",
                                      style: theme.testStyle.copyWith(
                                        fontSize: 16.o,
                                        fontWeight: FontWeight.w600,
                                        color: tema.primaryColorDark,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: expensList.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: Key(expensList[index].id),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      padding: EdgeInsets.only(right: 20.o),
                                      alignment: Alignment.centerRight,
                                      color: Colors.red,
                                      child: Icon(
                                        Icons.delete,
                                        color: theme.white,
                                      ),
                                    ),
                                    confirmDismiss: (direction) async {
                                      return await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(delete.tr),
                                            content: Text("${wantDelete.tr}?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    pop(context);
                                                  },
                                                  child: Text(no.tr)),
                                              TextButton(
                                                  onPressed: () {
                                                    ref
                                                        .read(expensProvider)
                                                        .delete(
                                                            expensList[index]
                                                                .id);
                                                    pop(context);
                                                  },
                                                  child: Text(yes.tr)),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundImage: (expensList[index]
                                                          .image !=
                                                      null &&
                                                  expensList[index]
                                                      .image!
                                                      .isNotEmpty)
                                              ? FileImage(File(
                                                  expensList[index].image!))
                                              : AssetImage(
                                                  Assets.image.placeholder)),
                                      title: Text(
                                        "${expensList[index].title}",
                                        style: theme.testStyle.copyWith(
                                          color: tema.primaryColorDark,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.o,
                                        ),
                                      ),
                                      subtitle: Text(
                                          "${DateFormat("MMM dd, h:mm a").format(expensList[index].sana ?? DateTime.now())}"),
                                      trailing: Text(
                                        "${expensList[index].isPrice ? "+" : "-"} ${expensList[index].price.toStringAsFixed(0)}",
                                        style: theme.testStyle.copyWith(
                                            color: tema.primaryColorDark,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.o),
                                      ),
                                    ),
                                  );
                                },
                              ))
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
