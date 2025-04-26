import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/keys.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/size.dart';
import 'package:flutter_wallet_app_lesson56/common/helpers/theme.dart';
import 'package:flutter_wallet_app_lesson56/view/auth/login_page.dart';
import 'package:flutter_wallet_app_lesson56/view/auth/splash_screen.dart';
import 'package:flutter_wallet_app_lesson56/view/bnb/bnb.dart';
import 'package:flutter_wallet_app_lesson56/view_model/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late SharedPreferences pref;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  if (pref.getString("language") == null) {
    await pref.setString("language", "uz");
  }
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: pref.getString("language") ?? "uz",
      supportedLocales: ["uz", "ru", "en"]);

  bool isLogedIn = pref.getBool("is_loged_in") ?? false;
  bool isOnboarding = pref.getBool("onboarding_seen") ?? false;

  Widget initialPage = isLogedIn
      ? BnbPage()
      : isOnboarding
          ? LoginPage()
          : SplashScreen();
  themeNotifier.init();
  runApp(LocalizedApp(delegate, ProviderScope(child: MyApp(initialPage))));
}

class MyApp extends StatelessWidget {
  final Widget initialPage;
  const MyApp(this.initialPage, {super.key, required});

  @override
  Widget build(BuildContext context) {
    final local = LocalizedApp.of(context).delegate;
    lang = pref.getString("language") ?? local.currentLocale.languageCode;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: Consumer(
        builder: (context, ref, child) {
          final notifier = ref.watch(themeProvider);
          return MaterialApp(
            locale: Locale(lang),
            supportedLocales: local.supportedLocales,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              local
            ],
            theme: theme.light,
            darkTheme: theme.dark,
            themeMode: notifier.themeMode,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              height = 1.sh(context) / 812;
              width = 1.sw(context) / 375;
              arifmetik = (height + width) / 2;
              return MediaQuery(data: MediaQuery.of(context), child: child!);
            },
            home: initialPage,
          );
        },
      ),
    );
  }
}
