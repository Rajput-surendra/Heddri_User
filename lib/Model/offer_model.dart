import 'package:eshop_multivendor/Model/Section_Model.dart';

class NewOfferModel {
  NewOfferModel({
    required this.id,
    required this.type,
    required this.typeId,
    required this.image,
    required this.dateAdded,
    required this.discountPrice,
    required this.startDate,
    required this.endDate,
    required this.priceType,
    required this.data,
  });
  late final String id;
  late final String type;
  late final String typeId;
  late final String image;
  late final String dateAdded;
  late final String discountPrice;
  late final String startDate;
  late final String endDate;
  late final String priceType;
  late final Data data;

  NewOfferModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    typeId = json['type_id'];
    image = json['image'];
    dateAdded = json['date_added'];
    discountPrice = json['discount_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    priceType = json['price_type'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['type_id'] = typeId;
    _data['image'] = image;
    _data['date_added'] = dateAdded;
    _data['discount_price'] = discountPrice;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['price_type'] = priceType;
   // _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.total,
    required this.minPrice,
    required this.maxPrice,
    required this.product,
    required this.filters,
  });
  late final String total;
  late final String minPrice;
  late final String maxPrice;
  late final List<Product> product;
  late final List<dynamic> filters;

  Data.fromJson(Map<String, dynamic> json){
    total = json['total'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    product = List.from(json['product']).map((e)=>Product.fromJson(e)).toList();
    filters = List.castFrom<dynamic, dynamic>(json['filters']);
  }

  /*Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['min_price'] = minPrice;
    _data['max_price'] = maxPrice;
    _data['product'] = product.map((e)=>e.toJson()).toList();
    _data['filters'] = filters;
    return _data;
  }*/
}