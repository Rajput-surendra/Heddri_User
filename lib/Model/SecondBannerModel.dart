import 'dart:convert';
/// error : true
/// message : "Data Succesfully Show"
/// data : [{"id":"2","type":"default","type_id":"0","image":"uploads/media/2022/Banner-1.jpg","date_added":"2022-04-25 17:57:22","link":""}]

SecondBannerModel secondBannerModelFromJson(String str) => SecondBannerModel.fromJson(json.decode(str));
String secondBannerModelToJson(SecondBannerModel data) => json.encode(data.toJson());
class SecondBannerModel {
  SecondBannerModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  SecondBannerModel.fromJson(dynamic json) {
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
SecondBannerModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => SecondBannerModel(  error: error ?? _error,
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

/// id : "2"
/// type : "default"
/// type_id : "0"
/// image : "uploads/media/2022/Banner-1.jpg"
/// date_added : "2022-04-25 17:57:22"
/// link : ""

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? type, 
      String? typeId, 
      String? image, 
      String? dateAdded, 
      String? link,}){
    _id = id;
    _type = type;
    _typeId = typeId;
    _image = image;
    _dateAdded = dateAdded;
    _link = link;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _typeId = json['type_id'];
    _image = json['image'];
    _dateAdded = json['date_added'];
    _link = json['link'];
  }
  String? _id;
  String? _type;
  String? _typeId;
  String? _image;
  String? _dateAdded;
  String? _link;
Data copyWith({  String? id,
  String? type,
  String? typeId,
  String? image,
  String? dateAdded,
  String? link,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  typeId: typeId ?? _typeId,
  image: image ?? _image,
  dateAdded: dateAdded ?? _dateAdded,
  link: link ?? _link,
);
  String? get id => _id;
  String? get type => _type;
  String? get typeId => _typeId;
  String? get image => _image;
  String? get dateAdded => _dateAdded;
  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['type_id'] = _typeId;
    map['image'] = _image;
    map['date_added'] = _dateAdded;
    map['link'] = _link;
    return map;
  }

}