import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shop_app_getx/view/shop/model/product.dart';

abstract class IProductService {
  final Dio _dio;

  IProductService(this._dio);

  Future<List<Product?>?> getAllProducts();
}

class ProductService extends IProductService {
  ProductService(Dio dio) : super(dio);

  @override
  Future<List<Product?>?> getAllProducts() async {
    Response response = await _dio.get('/products',
        options: Options(contentType: Headers.formUrlEncodedContentType));
    if (response.statusCode == HttpStatus.ok) {
      final List productList = response.data;
      final List<Product>? products = productList.map((e) => Product.fromJson(e)).toList();
      return products;
    } else {
      return null; // can be a better solution other than null
    }
  }
}