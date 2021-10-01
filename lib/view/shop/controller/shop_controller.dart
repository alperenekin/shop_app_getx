import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shop_app_getx/view/shop/model/product.dart';
import 'package:shop_app_getx/view/shop/service/product_service.dart';

class ShopController extends GetxController{
  late IProductService _productService;

  var isLoading = false.obs;
  List<Product?>? productList = List<Product>.empty().obs;

  @override
  void onInit() {
    _productService = ProductService(Dio(BaseOptions(
        responseType: ResponseType.json, baseUrl: 'https://fakestoreapi.com')));
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    isLoading(true);
    var products = await _productService.getAllProducts();
    if(products != null){
      productList = products;
    }
    isLoading(false);

  }

}