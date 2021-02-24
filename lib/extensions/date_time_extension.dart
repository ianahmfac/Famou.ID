part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String get shortDayName {
    switch (this.weekday) {
      case 1:
        return "MON";
      case 2:
        return "TUE";
      case 3:
        return "WED";
      case 4:
        return "THU";
      case 5:
        return "FRI";
      case 6:
        return "SAT";
      default:
        return "SUN";
    }
  }

  String get fullDayName {
    switch (this.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        return "Sunday";
    }
  }

  String get monthName {
    switch (this.month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      default:
        return "December";
    }
  }

  String get dateAndTime => "${this.shortDayName} ${this.day}, ${this.hour}:00";

  String get fullDateAndTime =>
      "${this.fullDayName}, ${this.day} ${this.monthName} ${this.year}";
}
