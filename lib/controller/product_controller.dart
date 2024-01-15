import 'package:get/get.dart';
import 'package:shopping_cart/model/product.dart';

import '../utils/constants.dart';

class ProductController extends GetxController {
  List<Product> productList = [
    Product('Pullover', 'Black', 'L', AppImages.pullOver, 1, 51),
    Product('T-Shirt', 'Gray', 'L', AppImages.tShirt, 1, 30),
    Product('Sport Dress', 'Black', 'M', AppImages.sportDress, 1, 43),
  ];

  List<Product> getProducts() {
    return productList;
  }

  void incrementAmount(Product product) {
    if (product.amount < 5) {
      product.amount++;
      update();
    }

    if (product.amount == 5) {
      product.amount++;
      update();
      Get.snackbar(
        'Item Added!',
        'You have added 5 ${product.name} to your bag!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void decrementAmount(Product product) {
    if (product.amount > 1) {
      product.amount--;
      update();
    }
  }

  int calculateTotalAmount() {
    int totalAmount = 0;
    for (Product product in productList) {
      totalAmount += product.amount * product.price;
    }
    return totalAmount;
  }
}
