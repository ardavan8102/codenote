import 'package:shamsi_date/shamsi_date.dart';

String getNowDate() {

  const months = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  final now = DateTime.now();

  final shamsi = Jalali.fromDateTime(now);

  final date = '${shamsi.day} ${months[shamsi.month - 1]} ماه ${shamsi.year}';

  return date;

}