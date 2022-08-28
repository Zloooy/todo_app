import 'package:intl/intl.dart';

abstract class DateFormatter {
  // TODO использовать системную локаль
  static String formatDate(DateTime date) =>
      DateFormat.yMMMMEEEEd('ru_RU').format(date);
}
