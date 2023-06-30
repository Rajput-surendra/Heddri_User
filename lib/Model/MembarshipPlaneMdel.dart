/// error : false
/// message : "Data Succesfully Show"
/// data : [{"id":"17","plan":"test","image":"uploads/media/2022/51U3nJvK3nL.png","status":"1","plan_type":"3 days","price":"400"},{"id":"18","plan":"test","image":"uploads/media/2022/download_(12).jpg","status":"1","plan_type":"5 days","price":"550"}]

class MembarshipPlaneMdel {
  MembarshipPlaneMdel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  MembarshipPlaneMdel.fromJson(dynamic json) {
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
MembarshipPlaneMdel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => MembarshipPlaneMdel(  error: error ?? _error,
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

/// id : "17"
/// plan : "test"
/// image : "uploads/media/2022/51U3nJvK3nL.png"
/// status : "1"
/// plan_type : "3 days"
/// price : "400"

class Data {
  Data({
      String? id, 
      String? plan, 
      String? image, 
      String? status, 
      String? planType, 
      String? price,}){
    _id = id;
    _plan = plan;
    _image = image;
    _status = status;
    _planType = planType;
    _price = price;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _plan = json['plan'];
    _image = json['image'];
    _status = json['status'];
    _planType = json['plan_type'];
    _price = json['price'];
  }
  String? _id;
  String? _plan;
  String? _image;
  String? _status;
  String? _planType;
  String? _price;
Data copyWith({  String? id,
  String? plan,
  String? image,
  String? status,
  String? planType,
  String? price,
}) => Data(  id: id ?? _id,
  plan: plan ?? _plan,
  image: image ?? _image,
  status: status ?? _status,
  planType: planType ?? _planType,
  price: price ?? _price,
);
  String? get id => _id;
  String? get plan => _plan;
  String? get image => _image;
  String? get status => _status;
  String? get planType => _planType;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['plan'] = _plan;
    map['image'] = _image;
    map['status'] = _status;
    map['plan_type'] = _planType;
    map['price'] = _price;
    return map;
  }

}