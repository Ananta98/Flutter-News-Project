import 'dart:ui';
import 'package:timeago/timeago.dart' as timeago;

const Color primaryColor = Color(0xFF2967FF);
const Color grayColor = Color(0xFF8D8D8E);

String timeUntil(DateTime date) {
  return timeago.format(date, allowFromNow: true, locale: 'en');
}