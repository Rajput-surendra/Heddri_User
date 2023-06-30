/// error : false
/// message : "Data Succesfully Show"
/// data : [{"id":"25","plan":"Gold  5 Days","image":"uploads/media/2023/HotChickenFestival_1600.jpg","status":"1","plan_type":"5 days","price":"2000","purchase":"YES"}]

class GetMemberShipPlanModel {
  GetMemberShipPlanModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetMemberShipPlanModel.fromJson(dynamic json) {
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
GetMemberShipPlanModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetMemberShipPlanModel(  error: error ?? _error,
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

/// id : "25"
/// plan : "Gold  5 Days"
/// image : "uploads/media/2023/HotChickenFestival_1600.jpg"
/// status : "1"
/// plan_type : "5 days"
/// price : "2000"
/// purchase : "YES"

class Data {
  Data({
      String? id, 
      String? plan, 
      String? image, 
      String? status, 
      String? planType, 
      String? price, 
      String? purchase,}){
    _id = id;
    _plan = plan;
    _image = image;
    _status = status;
    _planType = planType;
    _price = price;
    _purchase = purchase;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _plan = json['plan'];
    _image = json['image'];
    _status = json['status'];
    _planType = json['plan_type'];
    _price = json['price'];
    _purchase = json['purchase'];
  }
  String? _id;
  String? _plan;
  String? _image;
  String? _status;
  String? _planType;
  String? _price;
  String? _purchase;
Data copyWith({  String? id,
  String? plan,
  String? image,
  String? status,
  String? planType,
  String? price,
  String? purchase,
}) => Data(  id: id ?? _id,
  plan: plan ?? _plan,
  image: image ?? _image,
  status: status ?? _status,
  planType: planType ?? _planType,
  price: price ?? _price,
  purchase: purchase ?? _purchase,
);
  String? get id => _id;
  String? get plan => _plan;
  String? get image => _image;
  String? get status => _status;
  String? get planType => _planType;
  String? get price => _price;
  String? get purchase => _purchase;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['plan'] = _plan;
    map['image'] = _image;
    map['status'] = _status;
    map['plan_type'] = _planType;
    map['price'] = _price;
    map['purchase'] = _purchase;
    return map;
  }

}