import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

TextStyle myStyle(double? size, Color? clr, [FontWeight? fw]) {
  return GoogleFonts.merriweather(
    fontSize: size,
    color: clr,
    fontWeight: fw,
  );
}

String dateFormat(DateTime selectedDate) {
  return DateFormat('dd-MM-yyyy').format(selectedDate);
}
