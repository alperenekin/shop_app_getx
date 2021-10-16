import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shop_app_getx/core/extension/content_extension.dart';
import 'package:shop_app_getx/view/shop/controller/shop_controller.dart';

class ShopView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
      ),
      body: buildObxBody(context),
    );
  }

  GetX buildObxBody(BuildContext context) {
    return GetX<ShopController>(
      init: ShopController(),
      initState: (_) {},
      builder: (controller) {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : buildShopGridView(context,controller);
      },
    );
  }

  GridView buildShopGridView(BuildContext context, ShopController controller) {
    return GridView.count(
      childAspectRatio: (.50),
      crossAxisCount: 2,
      children: List.generate(controller.productList?.length ?? 0, (index) {
        return productCard(context, index, controller);
      }),
    );
  }

  Card productCard(BuildContext context, int index, ShopController controller) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          productTitle(context, index, controller),
          productImage(context, index, controller),
          ratingChip(context, index, controller),
          priceRow(index, context, controller),
        ],
      ),
    );
  }

  Padding productTitle(BuildContext context, int index, ShopController controller) {
    return Padding(
      padding: context.paddingLowHorizontal,
      child: Text(
        controller.productList?[index]?.title ?? 'title',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Container productImage(BuildContext context, int index, ShopController controller) {
    return Container(
      width: context.width * 0.3,
      height: context.height * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              controller.productList?[index]?.image ?? 'image'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Chip ratingChip(BuildContext context, int index, ShopController controller) {
    return Chip(
      label: Container(
        width: context.width * 0.15,
        child: Row(
          children: [
            Icon(
              Icons.star_border,
              color: Colors.white,
            ),
            Text(controller.productList?[index]?.rating?.rate.toString() ??
                'count'),
          ],
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }

  Row priceRow(int index, BuildContext context, ShopController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '€ ${controller.productList?[index]?.price.toString() ??
              'price'}',
          style: Theme
              .of(context)
              .textTheme
              .headline5,
        ),
        Obx(() {
          return favouriteButton(index,controller);
        })
      ],
    );
  }

  IconButton favouriteButton(int index, ShopController controller) {
    return IconButton(
      icon: controller.productList![index]!.isFavourite.value
          ? Icon(
        Icons.favorite,
        color: Colors.red,
      )
          : Icon(
        Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        controller.productList?[index]?.changeFavourite();
      },
    );
  }
}
