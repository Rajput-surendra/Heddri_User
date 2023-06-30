/// error : false
/// message : "Data Succesfully Show"
/// data : [{"id":"18","title":"02:00 PM To 04:00 PM","from_time":"14:00:00","to_time":"16:00:00","last_order_time":"15:00:00","status":"1"},{"id":"17","title":"12:00 PM To 02:00 PM","from_time":"12:00:00","to_time":"14:00:00","last_order_time":"13:00:00","status":"1"},{"id":"16","title":"10:00 AM To 12:00 PM","from_time":"10:00:00","to_time":"12:00:00","last_order_time":"11:00:00","status":"1"}]

class TimeSlotModel {
  TimeSlotModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  TimeSlotModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
TimeSlotModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => TimeSlotModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "18"
/// title : "02:00 PM To 04:00 PM"
/// from_time : "14:00:00"
/// to_time : "16:00:00"
/// last_order_time : "15:00:00"
/// status : "1"

class Data {
  Data({
      String? id, 
      String? title, 
      String? fromTime, 
      String? toTime, 
      String? lastOrderTime, 
      String? status,}){
    _id = id;
    _title = title;
    _fromTime = fromTime;
    _toTime = toTime;
    _lastOrderTime = lastOrderTime;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _lastOrderTime = json['last_order_time'];
    _status = json['status'];
  }
  String? _id;
  String? _title;
  String? _fromTime;
  String? _toTime;
  String? _lastOrderTime;
  String? _status;
Data copyWith({  String? id,
  String? title,
  String? fromTime,
  String? toTime,
  String? lastOrderTime,
  String? status,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  lastOrderTime: lastOrderTime ?? _lastOrderTime,
  status: status ?? _status,
);
  String? get id => _id;
  String? get title => _title;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get lastOrderTime => _lastOrderTime;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['last_order_time'] = _lastOrderTime;
    map['status'] = _status;
    return map;
  }

}