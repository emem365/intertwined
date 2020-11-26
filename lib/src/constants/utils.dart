import 'package:intl/intl.dart';

class Utils{
  static formatDateTime(DateTime dateTime) => dateFormat.format(dateTime);
  static DateFormat dateFormat = DateFormat.yMd().add_jms();
}