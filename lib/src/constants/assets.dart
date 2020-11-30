class Assets {
  static const path = 'assets';
  static Logos logos = Logos(path);
  static Illustrations illustrations = Illustrations(path);
}

class Logos {
  final String path;
  Logos(String path) : this.path = '$path/icons';

  String get github => '$path/github.png';
  String get google => '$path/google.png';
}

class Illustrations {
  final String path;
  Illustrations(String path) : this.path = '$path/illustrations';

  String get forgotPassword => '$path/illustration7.svg';

  String get newUser => '$path/illustration20.svg';

  String get settingUp => '$path/illustration12.svg';

  String get somethingWrong => '$path/illustration13.svg';

  String get comingSoon1 => '$path/illustration2.svg';
  
  String get comingSoon2 => '$path/illustration6.svg';

  String get forgotPasswordPng => '$path/png/illustration7.png';

  String get newUserPng => '$path/png/illustration20.png';

  String get settingUpPng => '$path/png/illustration12.png';

  String get somethingWrongPng => '$path/png/illustration13.png';

  String get comingSoon1Png => '$path/png/illustration2.png';
  
  String get comingSoon2Png => '$path/png/illustration6.png';
}
