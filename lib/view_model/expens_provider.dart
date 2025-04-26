import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wallet_app_lesson56/models/expens_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final expensProvider = ChangeNotifierProvider(
  (ref) => expensNotifier,
);

ExpensNotifier? _expensNotifier;

ExpensNotifier get expensNotifier {
  _expensNotifier ??= ExpensNotifier();
  return _expensNotifier!;
}

class ExpensNotifier with ChangeNotifier {
  List<ExpensModel> _list = [];
  List<ExpensModel> get list {
    return _list;
  }

  double _totalBalance = 0;

  double get totalBalance => _totalBalance;

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final expensesString = prefs.getString("expenses") ?? "[]";
    final totalBalance = prefs.getDouble("total_balance") ?? 0.0;
    final List<dynamic> decodedList = jsonDecode(expensesString);
    _list = decodedList.map((item) => ExpensModel.fromJson(item)).toList();
    _totalBalance = totalBalance;
    notifyListeners();
  }

  ExpensNotifier() {
    _loadExpenses();
  }

  Future<void> _saveExpanse() async {
    final prefs = await SharedPreferences.getInstance();
    final expensesString = jsonEncode(_list.map((e) => e.toJson()).toList());
    await prefs.setString("expenses", expensesString);
    await prefs.setDouble("total_balance", _totalBalance);
  }

  void addExpense(ExpensModel newExpense) {
    if (newExpense.isPrice) {
      _totalBalance += newExpense.price; //Kirim
    } else {
      _totalBalance -= newExpense.price; //Chiqim
    }
    _list.add(newExpense);
    _saveExpanse();
    notifyListeners();
  }

  void delete(String id) {
    final expense = _list.firstWhere((expense) => expense.id == id);
    if (expense.isPrice) {
      _totalBalance -= expense.price; //Kirim ayrish
    } else {
      _totalBalance += expense.price; //Chiqim ayrish
    }
    _list.removeWhere((expense) => expense.id == id);
    _saveExpanse();
    notifyListeners();
  }
}
