import 'package:get/get.dart';

class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  final isFavourite = false.obs;


  Product(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = checkDouble(json['price']);
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }


  double? checkDouble(dynamic value){
    if(value is int){
      return value.toDouble();
    }else{
      return value;
    }
  }

  void changeFavourite(){
    isFavourite.value = !isFavourite.value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;

    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = checkDouble(json['rate']);
    count = checkString(json['count']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }

  double? checkDouble(dynamic value){
    if(value is int){
      return value.toDouble();
    }else{
      return value;
    }
  }

  int? checkString(dynamic value){
    if(value is String){
      return int.parse(value);
    }else{
      return value;
    }
  }
}