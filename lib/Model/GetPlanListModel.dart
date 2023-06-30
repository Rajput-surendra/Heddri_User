/// error : false
/// message : "Data Succesfully Show"
/// data : [{"id":"71","user_id":"200","name":"null","email":"null","plan_name":"Gold  5 Days","plan_type":"5 days","price":"2000","start_date":"2023-06-30","end_date":"2023-07-05","plan_id":"25"}]

class GetPlanListModel {
  GetPlanListModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetPlanListModel.fromJson(dynamic json) {
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
GetPlanListModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetPlanListModel(  error: error ?? _error,
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

/// id : "71"
/// user_id : "200"
/// name : "null"
/// email : "null"
/// plan_name : "Gold  5 Days"
/// plan_type : "5 days"
/// price : "2000"
/// start_date : "2023-06-30"
/// end_date : "2023-07-05"
/// plan_id : "25"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? name, 
      String? email, 
      String? planName, 
      String? planType, 
      String? price, 
      String? startDate, 
      String? endDate, 
      String? planId,}){
    _id = id;
    _userId = userId;
    _name = name;
    _email = email;
    _planName = planName;
    _planType = planType;
    _price = price;
    _startDate = startDate;
    _endDate = endDate;
    _planId = planId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _email = json['email'];
    _planName = json['plan_name'];
    _planType = json['plan_type'];
    _price = json['price'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _planId = json['plan_id'];
  }
  String? _id;
  String? _userId;
  String? _name;
  String? _email;
  String? _planName;
  String? _planType;
  String? _price;
  String? _startDate;
  String? _endDate;
  String? _planId;
Data copyWith({  String? id,
  String? userId,
  String? name,
  String? email,
  String? planName,
  String? planType,
  String? price,
  String? startDate,
  String? endDate,
  String? planId,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  name: name ?? _name,
  email: email ?? _email,
  planName: planName ?? _planName,
  planType: planType ?? _planType,
  price: price ?? _price,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  planId: planId ?? _planId,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get planName => _planName;
  String? get planType => _planType;
  String? get price => _price;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get planId => _planId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['plan_name'] = _planName;
    map['plan_type'] = _planType;
    map['price'] = _price;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['plan_id'] = _planId;
    return map;
  }

}