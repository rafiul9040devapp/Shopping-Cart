import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/theme/app_color.dart';

import '../model/product.dart';
import '../utils/constants.dart';

class ProductController extends GetxController {
  RxList<Product> productList = <Product>[
    Product('Pullover', 'Black', 'L', AppImages.pullOver, 1, 51),
    Product('T-Shirt', 'Gray', 'L', AppImages.tShirt, 1, 30),
    Product('Sport Dress', 'Black', 'M', AppImages.sportDress, 1, 43),
  ].obs;

  late RxInt totalAmount;
  late RxList<RxInt> productAmounts;
  late RxList<RxInt> productPrices;

  ProductController() {
    totalAmount = RxInt(
      productList.fold<int>(
        0,
        (sum, product) => sum + (product.amount * product.price),
      ),
    );

    productAmounts =
        productList.map((product) => RxInt(product.amount)).toList().obs;
    productPrices = productList
        .map((product) => RxInt(product.amount * product.price))
        .toList()
        .obs;
  }

  List<Product> getProducts() {
    return productList;
  }

  void incrementAmount(Product product) {
    if (product.amount < 5) {
      product.amount++;
      update();
    } else if (product.amount == 5) {
      Get.dialog(
        AlertDialog(
          backgroundColor: AppColor.white,
          title: Center(
            child: Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColor.text,
                fontWeight: FontWeight.bold,
                fontFamily: 'FontMain',
              ),
            ),
          ),
          content: Text(
            'You have added \n 5 \n ${product.name} to your bag!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.text,
              fontWeight: FontWeight.normal,
              fontFamily: 'FontMain',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(16.0),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: Text(
                'OKAY',
                style: TextStyle(
                  color: AppColor.white,
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.w200,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      product.amount++;
      update();
    }
    calculateTotalAmount();
    updateProductAmountsAndPrices();
  }

  void decrementAmount(Product product) {
    if (product.amount > 1) {
      product.amount--;
      update();
    }

    calculateTotalAmount();
    updateProductAmountsAndPrices();
  }

  void calculateTotalAmount() {
    totalAmount.value = productList.fold<int>(
      0,
      (sum, product) => sum + (product.amount * product.price),
    );
  }

  void updateProductAmountsAndPrices() {
    productAmounts
        .assignAll(productList.map((product) => RxInt(product.amount)));
    productPrices.assignAll(
        productList.map((product) => RxInt(product.amount * product.price)));
  }
}
