import 'package:intl/intl.dart';

String getSelectDateButtonTitle(date) {
  date ??= DateTime.now();

  return DateFormat('EE, d MMM yyyy').format(date);
}

String getMonthView(date) {
  date ??= DateTime.now();

  return DateFormat('MMM yyyy').format(date);
}

String getMessageResponseFromObject(val) {
  var res = "";

  if (val is String) {
    return val;
  } else {
    var emailErr = val['email'];
    var passErr = val['password'];
    var usernameErr = val['username'];
    var namaErr = val['nama'];

    if (emailErr != null) {
      res += "${emailErr.join('\n')}";
    }
    if (passErr != null) {
      res += "${passErr.join('\n')}";
    }
    if (usernameErr != null) {
      res += "${usernameErr.join('\n')}";
    }
    if (namaErr != null) {
      res += "${namaErr.join('\n')}";
    }

    return res;
  }
}

validateDatetime(DateTime date) {
  if (date != null && date != "null") {
    return DateFormat("yyyy-MM-dd").format(date).toString();
  } else {
    return DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
  }
}
