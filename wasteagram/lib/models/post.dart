const weekDays = [
  'placeholder',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

const months = [
  'placeholder',
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'December'
];

class Post {
  DateTime? date;
  int? quantity;
  String? photoURL;
  String? latitude;
  String? longitude;

  Post(
      {this.date, this.quantity, this.photoURL, this.latitude, this.longitude});

  String? get getDay {
    return this.date!.day.toString();
  }

  String? get getWeekday {
    return weekDays[this.date!.weekday];
  }

  String? get getMonth {
    return months[this.date!.month];
  }

  String? get getYear {
    return this.date!.year.toString();
  }

  String? get getQuantity {
    return this.quantity.toString();
  }

  String? get getPhoto {
    return this.photoURL;
  }

  String? get getLatitude {
    return this.latitude;
  }

  String? get getLongitude {
    return this.longitude;
  }
}
