class TimeConvert{


  static String timeLeft(int time) {

    String timeRemain;
    Duration _timeUntilDue = Duration(seconds: time); //due.difference(DateTime.now());

    int _dayUntil = _timeUntilDue.inDays;
    int _hoursUntil = _timeUntilDue.inHours - (_dayUntil * 24);
    int _minUntil = _timeUntilDue.inMinutes - (_dayUntil * 24 * 60) - (_hoursUntil * 60);
    int _secUntil = _timeUntilDue.inSeconds - (_dayUntil * 24 * 60 * 60) - (_hoursUntil * 60 * 60) - (_minUntil * 60);

    if(_dayUntil > 0){
      timeRemain = _dayUntil.toString() + "ມື້";
    }else if(_hoursUntil > 0){
      timeRemain =  _hoursUntil.toString() + "ຊົ່ວໂມງ";


    }else if(_minUntil > 0){
      timeRemain=   _minUntil.toString() + "ນາທີ";

    }else if(_secUntil > 0){
      timeRemain =  _secUntil.toString() + "ວິນາທີ";
    }else{
      timeRemain = "ໝົດເວລາ";
    }

    return timeRemain;
  }

}