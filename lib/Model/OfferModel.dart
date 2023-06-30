// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

OfferModel offerModelFromJson(String str) => OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
  OfferModel({
    this.error,
    this.data,
  });

  bool? error;
  List<OfferModelDatum>? data;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    error: json["error"],
    data: List<OfferModelDatum>.from(json["data"].map((x) => OfferModelDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OfferModelDatum {
  OfferModelDatum({
    this.id,
    this.type,
    this.typeId,
    this.image,
    this.dateAdded,
    this.discountPrice,
    this.startDate,
    this.endDate,
    this.priceType,
    this.data,
  });

  String? id;
  String? type;
  String? typeId;
  String? image;
  DateTime? dateAdded;
  String? discountPrice;
  DateTime? startDate;
  DateTime? endDate;
  String? priceType;
  List<DatumDatum>? data;

  factory OfferModelDatum.fromJson(Map<String, dynamic> json) => OfferModelDatum(
    id: json["id"],
    type: json["type"],
    typeId: json["type_id"],
    image: json["image"],
    dateAdded: DateTime.parse(json["date_added"]),
    discountPrice: json["discount_price"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    priceType: json["price_type"],
    data: List<DatumDatum>.from(json["data"].map((x) => DatumDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "type_id": typeId,
    "image": image,
    "date_added": dateAdded!.toIso8601String(),
    "discount_price": discountPrice,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "price_type": priceType,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DatumDatum {
  DatumDatum({
    this.total,
    this.sales,
    this.stockType,
    this.isPricesInclusiveTax,
    this.type,
    this.attrValueIds,
    this.sellerRating,
    this.sellerSlug,
    this.sellerNoOfRatings,
    this.sellerProfile,
    this.storeName,
    this.storeDescription,
    this.sellerId,
    this.sellerName,
    this.id,
    this.stock,
    this.name,
    this.categoryId,
    this.shortDescription,
    this.slug,
    this.description,
    this.totalAllowedQuantity,
    this.deliverableType,
    this.deliverableZipcodes,
    this.minimumOrderQuantity,
    this.quantityStepSize,
    this.codAllowed,
    this.rowOrder,
    this.rating,
    this.noOfRatings,
    this.image,
    this.isReturnable,
    this.isCancelable,
    this.cancelableTill,
    this.indicator,
    this.otherImages,
    this.videoType,
    this.video,
    this.tags,
    this.warrantyPeriod,
    this.guaranteePeriod,
    this.madeIn,
    this.availability,
    this.categoryName,
    this.taxPercentage,
    this.reviewImages,
    this.attributes,
    this.variants,
    this.minMaxPrice,
    this.deliverableZipcodesIds,
    this.isDeliverable,
    this.isPurchased,
    this.isFavorite,
    this.imageMd,
    this.imageSm,
    this.otherImagesSm,
    this.otherImagesMd,
    this.variantAttributes,
  });

  String? total;
  String? sales;
  dynamic stockType;
  String? isPricesInclusiveTax;
  String? type;
  String? attrValueIds;
  String? sellerRating;
  String? sellerSlug;
  String? sellerNoOfRatings;
  String? sellerProfile;
  String? storeName;
  String? storeDescription;
  String? sellerId;
  String? sellerName;
  String? id;
  dynamic stock;
  String? name;
  String? categoryId;
  String? shortDescription;
  String? slug;
  String? description;
  dynamic totalAllowedQuantity;
  String? deliverableType;
  dynamic deliverableZipcodes;
  String? minimumOrderQuantity;
  String? quantityStepSize;
  String? codAllowed;
  String? rowOrder;
  String? rating;
  String? noOfRatings;
  String? image;
  String? isReturnable;
  String? isCancelable;
  dynamic cancelableTill;
  String? indicator;
  List<dynamic>? otherImages;
  String? videoType;
  String? video;
  List<dynamic>? tags;
  String? warrantyPeriod;
  String? guaranteePeriod;
  dynamic madeIn;
  dynamic availability;
  String? categoryName;
  String? taxPercentage;
  List<dynamic>? reviewImages;
  List<dynamic>? attributes;
  List<Variant>? variants;
  MinMaxPrice? minMaxPrice;
  dynamic deliverableZipcodesIds;
  bool? isDeliverable;
  bool? isPurchased;
  String? isFavorite;
  String? imageMd;
  String? imageSm;
  List<dynamic>? otherImagesSm;
  List<dynamic>? otherImagesMd;
  List<dynamic>? variantAttributes;

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
    total: json["total"],
    sales: json["sales"],
    stockType: json["stock_type"],
    isPricesInclusiveTax: json["is_prices_inclusive_tax"],
    type: json["type"],
    attrValueIds: json["attr_value_ids"],
    sellerRating: json["seller_rating"],
    sellerSlug: json["seller_slug"],
    sellerNoOfRatings: json["seller_no_of_ratings"],
    sellerProfile: json["seller_profile"],
    storeName: json["store_name"],
    storeDescription: json["store_description"],
    sellerId: json["seller_id"],
    sellerName: json["seller_name"],
    id: json["id"],
    stock: json["stock"],
    name: json["name"],
    categoryId: json["category_id"],
    shortDescription: json["short_description"],
    slug: json["slug"],
    description: json["description"],
    totalAllowedQuantity: json["total_allowed_quantity"],
    deliverableType: json["deliverable_type"],
    deliverableZipcodes: json["deliverable_zipcodes"],
    minimumOrderQuantity: json["minimum_order_quantity"],
    quantityStepSize: json["quantity_step_size"],
    codAllowed: json["cod_allowed"],
    rowOrder: json["row_order"],
    rating: json["rating"],
    noOfRatings: json["no_of_ratings"],
    image: json["image"],
    isReturnable: json["is_returnable"],
    isCancelable: json["is_cancelable"],
    cancelableTill: json["cancelable_till"],
    indicator: json["indicator"],
    otherImages: List<dynamic>.from(json["other_images"].map((x) => x)),
    videoType: json["video_type"],
    video: json["video"],
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    warrantyPeriod: json["warranty_period"],
    guaranteePeriod: json["guarantee_period"],
    madeIn: json["made_in"],
    availability: json["availability"],
    categoryName: json["category_name"],
    taxPercentage: json["tax_percentage"],
    reviewImages: List<dynamic>.from(json["review_images"].map((x) => x)),
    attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    minMaxPrice: MinMaxPrice.fromJson(json["min_max_price"]),
    deliverableZipcodesIds: json["deliverable_zipcodes_ids"],
    isDeliverable: json["is_deliverable"],
    isPurchased: json["is_purchased"],
    isFavorite: json["is_favorite"],
    imageMd: json["image_md"],
    imageSm: json["image_sm"],
    otherImagesSm: List<dynamic>.from(json["other_images_sm"].map((x) => x)),
    otherImagesMd: List<dynamic>.from(json["other_images_md"].map((x) => x)),
    variantAttributes: List<dynamic>.from(json["variant_attributes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "sales": sales,
    "stock_type": stockType,
    "is_prices_inclusive_tax": isPricesInclusiveTax,
    "type": type,
    "attr_value_ids": attrValueIds,
    "seller_rating": sellerRating,
    "seller_slug": sellerSlug,
    "seller_no_of_ratings": sellerNoOfRatings,
    "seller_profile": sellerProfile,
    "store_name": storeName,
    "store_description": storeDescription,
    "seller_id": sellerId,
    "seller_name": sellerName,
    "id": id,
    "stock": stock,
    "name": name,
    "category_id": categoryId,
    "short_description": shortDescription,
    "slug": slug,
    "description": description,
    "total_allowed_quantity": totalAllowedQuantity,
    "deliverable_type": deliverableType,
    "deliverable_zipcodes": deliverableZipcodes,
    "minimum_order_quantity": minimumOrderQuantity,
    "quantity_step_size": quantityStepSize,
    "cod_allowed": codAllowed,
    "row_order": rowOrder,
    "rating": rating,
    "no_of_ratings": noOfRatings,
    "image": image,
    "is_returnable": isReturnable,
    "is_cancelable": isCancelable,
    "cancelable_till": cancelableTill,
    "indicator": indicator,
    "other_images": List<dynamic>.from(otherImages!.map((x) => x)),
    "video_type": videoType,
    "video": video,
    "tags": List<dynamic>.from(tags!.map((x) => x)),
    "warranty_period": warrantyPeriod,
    "guarantee_period": guaranteePeriod,
    "made_in": madeIn,
    "availability": availability,
    "category_name": categoryName,
    "tax_percentage": taxPercentage,
    "review_images": List<dynamic>.from(reviewImages!.map((x) => x)),
    "attributes": List<dynamic>.from(attributes!.map((x) => x)),
    "variants": List<dynamic>.from(variants!.map((x) => x.toJson())),
    "min_max_price": minMaxPrice!.toJson(),
    "deliverable_zipcodes_ids": deliverableZipcodesIds,
    "is_deliverable": isDeliverable,
    "is_purchased": isPurchased,
    "is_favorite": isFavorite,
    "image_md": imageMd,
    "image_sm": imageSm,
    "other_images_sm": List<dynamic>.from(otherImagesSm!.map((x) => x)),
    "other_images_md": List<dynamic>.from(otherImagesMd!.map((x) => x)),
    "variant_attributes": List<dynamic>.from(variantAttributes!.map((x) => x)),
  };
}

class MinMaxPrice {
  MinMaxPrice({
    this.minPrice,
    this.maxPrice,
    this.specialPrice,
    this.maxSpecialPrice,
    this.discountInPercentage,
  });

  int? minPrice;
  int? maxPrice;
  int? specialPrice;
  int? maxSpecialPrice;
  int? discountInPercentage;

  factory MinMaxPrice.fromJson(Map<String, dynamic> json) => MinMaxPrice(
    minPrice: json["min_price"],
    maxPrice: json["max_price"],
    specialPrice: json["special_price"],
    maxSpecialPrice: json["max_special_price"],
    discountInPercentage: json["discount_in_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "min_price": minPrice,
    "max_price": maxPrice,
    "special_price": specialPrice,
    "max_special_price": maxSpecialPrice,
    "discount_in_percentage": discountInPercentage,
  };
}

class Variant {
  Variant({
    this.id,
    this.productId,
    this.attributeValueIds,
    this.attributeSet,
    this.price,
    this.specialPrice,
    this.sku,
    this.stock,
    this.images,
    this.availability,
    this.status,
    this.dateAdded,
    this.variantIds,
    this.attrName,
    this.variantValues,
    this.swatcheType,
    this.swatcheValue,
    this.imagesMd,
    this.imagesSm,
    this.cartCount,
  });

  String? id;
  String? productId;
  String? attributeValueIds;
  String? attributeSet;
  String? price;
  String? specialPrice;
  String? sku;
  dynamic stock;
  List<dynamic>? images;
  String? availability;
  String? status;
  DateTime? dateAdded;
  String? variantIds;
  String? attrName;
  String? variantValues;
  String? swatcheType;
  String? swatcheValue;
  List<dynamic>? imagesMd;
  List<dynamic>? imagesSm;
  String? cartCount;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    productId: json["product_id"],
    attributeValueIds: json["attribute_value_ids"],
    attributeSet: json["attribute_set"],
    price: json["price"],
    specialPrice: json["special_price"],
    sku: json["sku"],
    stock: json["stock"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    availability: json["availability"],
    status: json["status"],
    dateAdded: DateTime.parse(json["date_added"]),
    variantIds: json["variant_ids"],
    attrName: json["attr_name"],
    variantValues: json["variant_values"],
    swatcheType: json["swatche_type"],
    swatcheValue: json["swatche_value"],
    imagesMd: List<dynamic>.from(json["images_md"].map((x) => x)),
    imagesSm: List<dynamic>.from(json["images_sm"].map((x) => x)),
    cartCount: json["cart_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "attribute_value_ids": attributeValueIds,
    "attribute_set": attributeSet,
    "price": price,
    "special_price": specialPrice,
    "sku": sku,
    "stock": stock,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "availability": availability,
    "status": status,
    "date_added": dateAdded!.toIso8601String(),
    "variant_ids": variantIds,
    "attr_name": attrName,
    "variant_values": variantValues,
    "swatche_type": swatcheType,
    "swatche_value": swatcheValue,
    "images_md": List<dynamic>.from(imagesMd!.map((x) => x)),
    "images_sm": List<dynamic>.from(imagesSm!.map((x) => x)),
    "cart_count": cartCount,
  };
}
