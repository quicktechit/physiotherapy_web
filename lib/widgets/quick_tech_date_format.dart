import 'package:intl/intl.dart';

class QuickTechDateFormat {




  static String formatDate(String date) {
    final DateFormat formatter = DateFormat('dd MMM, yyyy');

    return formatter.format(DateTime.parse(date));
  }

}
