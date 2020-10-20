

class Assets{
  static const path = 'assets';
  static Logos logos = Logos(path);
  static Illustrations illustrations = Illustrations(path);
}

class Logos{
  final String path;
  Logos(String path) : this.path = '$path/icons';

  String get github => '$path/github.png';
  String get google => '$path/google.png';
}

class Illustrations{
  final String path;
  Illustrations(String path) : this.path = '$path/illustrations';

  String get forgotPassword => '$path/illustration7.svg';

  String get newUser => '$path/illustration20.svg';

  String get settingUp => '$path/illustration12.svg';

  String get somethingWrong => '$path/illustration13.svg';
}