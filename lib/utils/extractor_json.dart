import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class Extractor {
  static final Extractor _singleton = new Extractor._internal();
  factory Extractor() {
    return _singleton;
  }
  Extractor._internal();

  static String extractString(value, String defaultValue) {
    return (value != null && value != '') ? value.toString() : defaultValue;
  }

  static double extractDouble(value) {
    try {
      return value != null ? double.parse(value.toString()) : 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  static bool extractBool(value) {
    if(value is int){
      return value == 1 ? true : false;
    }else if(value is String){
      return value == "1" ? true : false;
    }
    else return value == true ? true : false;
  }

  static int extractBoolToInt(value) {
    return (value == true ? 1 : (value == false ? 0: null));
  }

  static DateTime extractDate(value) {
    try {
      if(value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      else return value != null ? DateTime.parse(value) : null;
    } catch (e) {
      return null;
    }
  }

  static String extractDateII(value) {
    try {
      if (value != null) return formatDate( value, [yyyy, '-', mm, '-', dd, 'T', HH, ':', nn, ':', ss]) + 'Z';
      else return null;
    } catch (e) {
      return null;
    }
  }

  static String extractDateIII(value) {
    try {
      if (value != null) return formatDate(value, [yyyy, '-', mm, '-', dd]);
      else return null;
    } catch (e) {
      return null;
    }
  }

  static String extractDateIV(date) { //date==DateTime()
    var format = new DateFormat.yMMMM("pt_BR");

    return  format.format(date).toUpperCase();
  }

  static int extractDateV(DateTime value) {
    try {
      if(value != null) return value.millisecondsSinceEpoch;
      else return null;
    } catch (e) {
      return null;
    }
  }

  static double extractHour(time) {
    try {
      var array = time.split(':');

      var hr = int.parse(array[0]);
      var min = (int.parse(array[1]) / 60);

      return (hr + min);
    } catch (e) {
      return null;
    }
  }

  static int extractInt(value) {
    try {
      if(value is double) return value.round();
      else return value != null ? int.parse(value.toString()) : 0;
    } catch (e) {
      return 0;
    }
  }

  static List<String> diasSemana(List<bool> dias) {
    try {
      List<String> diasSemana = [];
      for (var i = 0; i < dias.length; i++) {
        if (dias[i]) {
          if (i == 0)
            diasSemana.add('DOMINGO');
          else if (i == 1)
            diasSemana.add('SEGUNDA');
          else if (i == 2)
            diasSemana.add('TERCA');
          else if (i == 3)
            diasSemana.add('QUARTA');
          else if (i == 4)
            diasSemana.add('QUINTA');
          else if (i == 5)
            diasSemana.add('SEXTA');
          else if (i == 6) diasSemana.add('SABADO');
        }
      }

      return diasSemana;
    } catch (e) {
      return [];
    }
  }

  static String convertToHHMM(info) {
    try {
      var hrs = info.toInt();
      var min = ((info-hrs) * 60).round().abs();
      
      var hrsII = (hrs.toString().length==1?('0'+hrs.toString()):hrs.toString());
      var minII = (min.toString().length==1?('0'+min.toString()):min.toString());

      return hrsII+':'+minII;
    } catch (e) {
      return '00:00';
    }
  }

  static double timeStringToDouble(time) {
    try {
      var hoursMinutes = time.split(':');
      var hours = int.parse(hoursMinutes[0]);
      var minutes = int.parse(hoursMinutes[1]);
      
      return hours + minutes / 60;
    } catch (e) {
      return 0.0;
    }
  }

  static bool validEmail(text){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(text);
  }
  
  static String extractCpfCnpj(value){
    try {
      if(value != null) return value.replaceAll('.', '').replaceAll('-', '').replaceAll('/', '');
      else return null;
    } catch (e) {
      return null;
    }
  }

  static String extractMoneyII(valor){
    try {
      if(valor != null){
        var str = valor.toString().lastIndexOf('0');

        if (str == (valor.toString().length - 1)) return valor.toString() + '0';
        else if (valor.toString().length <= 3) return valor.toString() + '0';
        else return valor.toString();
      }
      else return '0.0';
    } catch (e) {
      return '0.0';
    }
  }

}
