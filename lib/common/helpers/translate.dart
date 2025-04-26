import 'package:flutter_translate/flutter_translate.dart';

extension Translate on String {
  String get tr => translate(this);
}

String next = 'AUTH.NEXT';
String skip = 'AUTH.SKIP';
String onboardingTitle1 = 'AUTH.ONBOARD1';
String onboardingTitle2 = 'AUTH.ONBOARD2';
String onboardingTitle3 = 'AUTH.ONBOARD3';
String start = 'AUTH.START';
String userImage = 'AUTH.USERIMAGE';
String name = 'AUTH.NAME';
String login = 'AUTH.LOGIN';

String panel = 'HOME.PANEL';
String hello = 'HOME.HELLO';
String balance = 'HOME.BALANCE';
String home = 'HOME.HOME';
String expense = 'HOME.EXPENSE';
String request = 'HOME.REQUEST';
String profile = 'HOME.PROFILE';
String sum = 'HOME.SUM';
String recentTr = 'HOME.RECENTTR';
String expenses = 'HOME.EXPENSES';
String requests = 'HOME.REQUESTS';
String noTransactions = 'HOME.NOTRANSACTIONS';
String delete = 'HOME.DELETE';
String yes = 'HOME.YES';
String no = 'HOME.NO';
String wantDelete = 'HOME.WANTDELETE';

String sent = 'EXPENSE.SENT';
String sentImage = 'EXPENSE.SENTIMAGE';
String sentName = 'EXPENSE.SENTNAME';
String sentSumma = 'EXPENSE.SENTSUMMA';
String dateTime = 'EXPENSE.DATETIME';
String save = 'EXPENSE.SAVE';
String snackBarAlert = 'EXPENSE.SNACKBARALERT';
String sentAded = 'EXPENSE.SENTADED';

String income = 'REQUEST.INCOME';
String incomeImage = 'REQUEST.INCOMEIMAGE';
String incomeName = 'REQUEST.INCOMENAME';
String incomeSumma = 'REQUEST.INCOMESUMMA';
String incomeDateTime = 'REQUEST.INCOMEDATETIME';
String incomeSave = 'REQUEST.INCOMESAVE';
String incomeSnackBarAlert = 'REQUEST.INCOMESNACKBARALERT';
String incomeAded = 'REQUEST.INCOMEADED';

String profil = 'PROFILE.PROFILE';
String profileImage = 'PROFILE.PROFILEIMAGE';
String profileTheme = 'PROFILE.PROFILETHEME';
String profileLanguage = 'PROFILE.PROFILELANGUAGE';
String uz = 'PROFILE.UZ';
String ru = 'PROFILE.RU';
String en = 'PROFILE.EN';
