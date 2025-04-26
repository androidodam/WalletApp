abstract class Assets {
  const Assets._();
  static _Icon get icon => const _Icon();
  static _Image get image => const _Image();
}

abstract class _AssetsHolder {
  final String basePath;

  const _AssetsHolder(this.basePath);
}

class _Icon extends _AssetsHolder {
  const _Icon() : super("assets/icons");

  String get textLogo => "$basePath/TextLogo.svg";
  String get user => "$basePath/user.svg";
  String get home => "$basePath/home.svg";
  String get send => "$basePath/send.svg";
  String get request => "$basePath/request.svg";
  String get requestWhite => "$basePath/request_white.svg";
  String get username => "$basePath/username.svg";
  String get dark => "$basePath/dark.svg";
  String get globe => "$basePath/globe.svg";
  String get uzb => "$basePath/uzb.svg";
  String get rus => "$basePath/rus.svg";
  String get us => "$basePath/us.svg";
}

class _Image extends _AssetsHolder {
  const _Image() : super("assets/images");

  String get onboarding1 => "$basePath/onboarding1.png";
  String get onboarding2 => "$basePath/onboarding2.png";
  String get onboarding3 => "$basePath/onboarding3.png";
  String get loginLight => "$basePath/loginLight.png";
  String get loginDark => "$basePath/loginDark.png";
  String get homebg => "$basePath/Background.png";
  String get img1 => "$basePath/img1.png";
  String get img2 => "$basePath/img2.png";
  String get img3 => "$basePath/img3.png";
  String get img4 => "$basePath/img4.png";
  String get img5 => "$basePath/img5.png";
  String get placeholder => "$basePath/placeholder.png";
  String get empty => "$basePath/empty.png";
}
