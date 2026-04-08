import 'dart:convert';

FoodModuleModel foodModuleModelFromJson(String str) =>
    FoodModuleModel.fromJson(json.decode(str));

String foodModuleModelToJson(FoodModuleModel data) =>
    json.encode(data.toJson());

class FoodModuleModel {
  int status;
  ResultFoodModuleModel result;

  FoodModuleModel({required this.status, required this.result});

  factory FoodModuleModel.fromJson(Map<String, dynamic> json) =>
      FoodModuleModel(
        status: json["status"],
        result: ResultFoodModuleModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result.toJson(),
  };
}

class ResultFoodModuleModel {
  List<FoodBannerSlider> foodBanner;
  List<ShopCategory> shopCategory;
  List<PopularProduct> popularProduct;
  List<FoodDeliveryBanner> foodDeliveryBanner;
  List<ProductRecommend> productRecommend;
  BestDrink bestDrink;
  List<FilterStore> filterStore;
  ResultFoodModuleModel({
    required this.foodBanner,
    required this.shopCategory,
    required this.popularProduct,
    required this.foodDeliveryBanner,
    required this.productRecommend,
    required this.bestDrink,
    required this.filterStore,
  });

  factory ResultFoodModuleModel.fromJson(Map<String, dynamic> json) =>
      ResultFoodModuleModel(
        foodBanner: List<FoodBannerSlider>.from(
          json["foodBanner"].map((x) => FoodBannerSlider.fromJson(x)),
        ),
        shopCategory: List<ShopCategory>.from(
          json["shopCategory"].map((x) => ShopCategory.fromJson(x)),
        ),

        popularProduct: List<PopularProduct>.from(
          json["popularProduct"].map((x) => PopularProduct.fromJson(x)),
        ),
        foodDeliveryBanner: List<FoodDeliveryBanner>.from(
          json["foodDeliveryBanner"].map((x) => FoodDeliveryBanner.fromJson(x)),
        ),

        productRecommend: List<ProductRecommend>.from(
          json["productRecommend"].map((x) => ProductRecommend.fromJson(x)),
        ),
        bestDrink: BestDrink.fromJson(json["bestDrink"]),
        filterStore: List<FilterStore>.from(
          json["filterStore"].map((x) => FilterStore.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "foodBanner": List<dynamic>.from(foodBanner.map((x) => x.toJson())),
    "shopCategory": List<dynamic>.from(shopCategory.map((x) => x.toJson())),

    "popularProduct": List<dynamic>.from(popularProduct.map((x) => x.toJson())),
    "foodDeliveryBanner": List<dynamic>.from(
      foodDeliveryBanner.map((x) => x.toJson()),
    ),
    "productRecommend": List<ProductRecommend>.from(
      productRecommend.map((x) => x.toJson()),
    ),
    "bestDrink": bestDrink.toJson(),
    "filterStore": List<dynamic>.from(filterStore.map((x) => x.toJson())),
  };
}

class BestDrink {
  String title;
  List<BestDrinkResult> result;

  BestDrink({required this.title, required this.result});

  factory BestDrink.fromJson(Map<String, dynamic> json) => BestDrink(
    title: json["title"],
    result: List<BestDrinkResult>.from(
      json["result"].map((x) => BestDrinkResult.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class BestDrinkResult {
  int id;
  String title;
  String titleKh;
  int productId;
  int categoryId;
  int shopId;
  String productName;
  String productNameKh;
  dynamic description;
  dynamic descriptionKh;
  String image;
  String productImage;
  String shopName;
  String shopNameKh;
  String shopType;
  dynamic price;
  dynamic discount;
  dynamic discountType;
  int variantId;
  dynamic priceAfterDiscount;

  BestDrinkResult({
    required this.id,
    required this.title,
    required this.titleKh,
    required this.productId,
    required this.categoryId,
    required this.shopId,
    required this.productName,
    required this.productNameKh,
    required this.description,
    required this.descriptionKh,
    required this.image,
    required this.productImage,
    required this.shopName,
    required this.shopNameKh,
    required this.shopType,
    required this.price,
    required this.discount,
    required this.discountType,
    required this.variantId,
    required this.priceAfterDiscount,
  });

  factory BestDrinkResult.fromJson(Map<String, dynamic> json) =>
      BestDrinkResult(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        titleKh: json["title_kh"] ?? "",
        productId: json["product_id"] ?? 0,
        categoryId: json["category_id"] ?? 0,
        shopId: json["shopId"] ?? 0,
        productName: json["product_name"] ?? "",
        productNameKh: json["product_name_kh"] ?? "",
        description: json["description"] ?? "",
        descriptionKh: json["description_kh"] ?? "",
        image: json["image"] ?? "",
        productImage: json["product_image"] ?? "",
        shopName: json["shop_name"] ?? "",
        shopNameKh: json["shop_name_kh"] ?? "",
        shopType: json["shop_type"] ?? "",
        price: json["price"] ?? "",
        discount: json["discount"] ?? "",
        discountType: json["discount_type"] ?? "",
        variantId: json["variant_id"] ?? 0,
        priceAfterDiscount: json["price_after_discount"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "title_kh": titleKh,
    "product_id": productId,
    "category_id": categoryId,
    "shopId": shopId,
    "product_name": productName,
    "product_name_kh": productNameKh,
    "description": description,
    "description_kh": descriptionKh,
    "image": image,
    "product_image": productImage,
    "shop_name": shopName,
    "shop_name_kh": shopNameKh,
    "shop_type": shopType,
    "price": price,
    "discount": discount,
    "discount_type": discountType,
    "variant_id": variantId,
    "price_after_discount": priceAfterDiscount,
  };
}

class FoodBannerSlider {
  int id;
  int storeId;
  String image;
  String type;

  FoodBannerSlider({
    required this.id,
    required this.storeId,
    required this.image,
    required this.type,
  });

  factory FoodBannerSlider.fromJson(Map<String, dynamic> json) =>
      FoodBannerSlider(
        id: json["id"] ?? 0,
        storeId: json["storeId"] ?? 0,
        image: json["image"] ?? "",
        type: json["type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "storeId": storeId,
    "image": image,
    "type": type,
  };
}

class FoodDeliveryBanner {
  int id;
  String bannerImage;
  int shopId;
  String shopType;

  FoodDeliveryBanner({
    required this.id,
    required this.bannerImage,
    required this.shopId,
    required this.shopType,
  });

  factory FoodDeliveryBanner.fromJson(Map<String, dynamic> json) =>
      FoodDeliveryBanner(
        id: json["id"] ?? 0,
        bannerImage: json["banner_image"] ?? "",
        shopId: json["shop_id"] ?? 0,
        shopType: json["shop_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banner_image": bannerImage,
    "shop_id": shopId,
    "shop_type": shopType,
  };
}

class ShopCategory {
  int id;
  String name;
  String nameKh;
  String image;

  ShopCategory({
    required this.id,
    required this.name,
    required this.nameKh,
    required this.image,
  });

  factory ShopCategory.fromJson(Map<String, dynamic> json) => ShopCategory(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    nameKh: json["name_kh"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_kh": nameKh,
    "image": image,
  };
}

class FilterStore {
  int id;
  String name;
  String value;

  FilterStore({required this.id, required this.name, required this.value});

  factory FilterStore.fromJson(Map<String, dynamic> json) =>
      FilterStore(id: json["id"], name: json["name"], value: json["value"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "value": value};
}

class FreeDelivery {
  int id;
  String type;
  String image;
  int shopId;

  FreeDelivery({
    required this.id,
    required this.type,
    required this.image,
    required this.shopId,
  });

  factory FreeDelivery.fromJson(Map<String, dynamic> json) => FreeDelivery(
    id: json["id"] ?? 0,
    type: json["type"] ?? "",
    image: json["image"] ?? "",
    shopId: json["shop_id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "image": image,
    "shop_id": shopId,
  };
}

class ProductRecommend {
  int id;
  String name;
  String nameKh;
  String image;
  int shopId;
  String shopName;
  String shopNameKh;
  String shopStatus;
  dynamic estimateDistance;
  String estimateTime;
  dynamic deliveryFee;
  dynamic deliveryFeeDiscount;

  ProductRecommend({
    required this.id,
    required this.name,
    required this.nameKh,
    required this.image,
    required this.shopId,
    required this.shopName,
    required this.shopNameKh,
    required this.shopStatus,
    required this.estimateDistance,
    required this.estimateTime,
    required this.deliveryFee,
    required this.deliveryFeeDiscount,
  });

  factory ProductRecommend.fromJson(Map<String, dynamic> json) =>
      ProductRecommend(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        nameKh: json["name_kh"] ?? "",
        image: json["image"] ?? "",
        shopId: json["shopId"] ?? "",
        shopName: json["shopName"] ?? "",
        shopNameKh: json["shopNameKh"] ?? "",
        shopStatus: json["shopStatus"],
        estimateDistance: json["estimateDistance"] ?? "",
        estimateTime: json["estimateTime"],
        deliveryFee: json["deliveryFee"] ?? "",
        deliveryFeeDiscount: json["deliveryFeeDiscount"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_kh": nameKh,
    "image": image,
    "shopId": shopId,
    "shopName": shopName,
    "shopNameKh": shopNameKh,
    "shopStatus": shopStatus,
    "estimateDistance": estimateDistance,
    "estimateTime": estimateTime,
    "deliveryFee": deliveryFee,
    "deliveryFeeDiscount": deliveryFeeDiscount,
  };
}

class PopularProduct {
  int totalOrdered;
  int shopId;
  String shopName;
  String shopNameKh;
  String type;
  dynamic shopLat;
  dynamic shopLng;
  String shopCover;
  int id;
  String name;
  String nameKh;
  String image;
  dynamic promotion;
  dynamic promotionType;
  dynamic price;
  dynamic priceAfterDiscount;
  String shopStatus;
  dynamic description;
  dynamic descriptionKh;
  dynamic estimateDistance;
  String estimateTime;
  dynamic deliveryFee;

  PopularProduct({
    required this.totalOrdered,
    required this.shopId,
    required this.shopName,
    required this.shopNameKh,
    required this.type,
    required this.shopLat,
    required this.shopLng,
    required this.shopCover,
    required this.id,
    required this.name,
    required this.nameKh,
    required this.image,
    required this.promotion,
    required this.promotionType,
    required this.price,
    required this.priceAfterDiscount,
    required this.shopStatus,
    required this.description,
    required this.descriptionKh,
    required this.estimateDistance,
    required this.estimateTime,
    this.deliveryFee,
  });

  factory PopularProduct.fromJson(Map<String, dynamic> json) => PopularProduct(
    totalOrdered: json["total_ordered"],
    shopId: json["shopId"],
    shopName: json["shopName"] ?? "",
    shopNameKh: json["shopNameKh"] ?? "",
    type: json["type"],
    shopLat: json["shopLat"] ?? "0",
    shopLng: json["shopLng"] ?? "0",
    shopCover: json["shopCover"] ?? "",
    id: json["id"],
    name: json["name"] ?? "",
    nameKh: json["name_kh"] ?? "",
    image: json["image"] ?? "",
    promotion: json["promotion"] ?? "",
    promotionType: json["promotionType"] ?? "",
    price: json["price"] ?? "",
    priceAfterDiscount: json["priceAfterDiscount"] ?? "",
    shopStatus: json["shopStatus"] ?? "",
    description: json["description"] ?? "",
    descriptionKh: json["descriptionKh"] ?? "",
    estimateDistance: json["estimateDistance"] ?? "0",
    estimateTime: json["estimateTime"] ?? "",
    deliveryFee: json["deliveryFee"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "total_ordered": totalOrdered,
    "shopId": shopId,
    "shopName": shopName,
    "shopNameKh": shopNameKh,
    "type": type,
    "shopLat": shopLat,
    "shopLng": shopLng,
    "shopCover": shopCover,
    "id": id,
    "name": name,
    "name_kh": nameKh,
    "image": image,
    "promotion": promotion,
    "promotionType": promotionType,
    "price": price,
    "priceAfterDiscount": priceAfterDiscount,
    "shopStatus": shopStatus,
    "description": description,
    "descriptionKh": descriptionKh,
    "estimateDistance": estimateDistance,
    "estimateTime": estimateTime,
  };
}

class PromotionProduct {
  int productId;
  String productImage;
  String productNameEn;
  String productNameKh;
  dynamic shopLat;
  dynamic shopLng;
  int shopId;
  String shopName;
  String shopNameKh;
  String shopType;
  dynamic productPrice;
  dynamic discount;
  dynamic productAfterDiscount;
  String discountType;
  int favoriteStatus;

  PromotionProduct({
    required this.productId,
    required this.productImage,
    required this.productNameEn,
    required this.productNameKh,
    required this.shopLat,
    required this.shopLng,
    required this.shopId,
    required this.shopName,
    required this.shopNameKh,
    required this.shopType,
    required this.productPrice,
    required this.discount,
    required this.productAfterDiscount,
    required this.discountType,
    required this.favoriteStatus,
  });

  factory PromotionProduct.fromJson(Map<String, dynamic> json) =>
      PromotionProduct(
        productId: json["product_id"],
        productImage: json["product_image"] ?? "",
        productNameEn: json["product_name_en"] ?? "",
        productNameKh: json["product_name_kh"] ?? "",
        shopLat: json["shopLat"] ?? "0",
        shopLng: json["shopLng"] ?? "0",
        shopId: json["shop_id"],
        shopName: json["shop_name"] ?? "",
        shopNameKh: json["shop_name_kh"] ?? "",
        shopType: json["shop_type"] ?? "",
        productPrice: json["product_price"] ?? "0",
        discount: json["discount"] ?? "",
        productAfterDiscount: json["product_after_discount"] ?? "0",
        discountType: json["discount_type"] ?? "",
        favoriteStatus: json["favoriteStatus"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_image": productImage,
    "product_name_en": productNameEn,
    "product_name_kh": productNameKh,
    "shopLat": shopLat,
    "shopLng": shopLng,
    "shop_id": shopId,
    "shop_name": shopName,
    "shop_name_kh": shopNameKh,
    "shop_type": shopType,
    "product_price": productPrice,
    "discount": discount,
    "product_after_discount": productAfterDiscount,
    "discount_type": discountType,
    "favoriteStatus": favoriteStatus,
  };
}
