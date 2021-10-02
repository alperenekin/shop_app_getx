import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:shop_app_getx/core/extension/content_extension.dart';
import 'package:shop_app_getx/view/shop/controller/shop_controller.dart';

class ShopView extends StatelessWidget {
  final ShopController shopController = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
      ),
      body: buildObxBody(context),
    );
  }

  Obx buildObxBody(BuildContext context) {
    return Obx(() {
      return shopController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : buildShopGridView(context);
    });
  }

  GridView buildShopGridView(BuildContext context) {
    return GridView.count(
      childAspectRatio: (.50),
      crossAxisCount: 2,
      children: List.generate(shopController.productList?.length ?? 0, (index) {
        return productCard(context, index);
      }),
    );
  }

  Card productCard(BuildContext context, int index) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          productTitle(context, index),
          productImage(context, index),
          ratingChip(context, index),
          priceRow(index, context),
        ],
      ),
    );
  }

  Padding productTitle(BuildContext context, int index) {
    return Padding(
      padding: context.paddingLowHorizontal,
      child: Text(
        shopController.productList?[index]?.title ?? 'title',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Container productImage(BuildContext context, int index) {
    return Container(
      width: context.width * 0.3,
      height: context.height * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              shopController.productList?[index]?.image ?? 'image'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Chip ratingChip(BuildContext context, int index) {
    return Chip(
      label: Container(
        width: context.width * 0.15,
        child: Row(
          children: [
            Icon(
              Icons.star_border,
              color: Colors.white,
            ),
            Text(shopController.productList?[index]?.rating?.rate.toString() ??
                'count'),
          ],
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }

  Row priceRow(int index, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '€ ${shopController.productList?[index]?.price.toString() ?? 'price'}',
          style: Theme.of(context).textTheme.headline5,
        ),
        Obx(() {
          return favouriteButton(index);
        })
      ],
    );
  }

  IconButton favouriteButton(int index) {
    return IconButton(
      icon: shopController.productList![index]!.isFavourite.value
          ? Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
      onPressed: () {
        shopController.productList?[index]?.changeFavourite();
      },
    );
  }
}
