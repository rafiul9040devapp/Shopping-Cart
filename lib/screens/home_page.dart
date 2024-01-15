import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/theme/app_color.dart';
import '../controller/product_controller.dart';
import '../model/product.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              Icons.search,
              color: AppColor.black,
              size: 24.sp,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Bag',
              style: TextStyle(
                  color: AppColor.text,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'FontMain'),
            ),
            10.verticalSpace,
            Expanded(
              child: ListView.builder(
                itemCount: controller.productList.length,
                itemBuilder: (context, index) {
                  final Product product = controller.productList[index];
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: 4.h),
                    child: Card(
                      color: AppColor.background,
                      elevation: 5,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            product.image,
                            height: 100.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Text(
                                product.name,
                                style: TextStyle(
                                    fontFamily: 'FontMain',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.more_vert_rounded,
                                color: AppColor.icon,
                                size: 30.sp,
                              ),
                            )
                          ],
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontFamily: 'FontMain',
                                          fontSize: 12.sp),
                                      children: [
                                        const TextSpan(
                                          text: 'Color: ',
                                          style: TextStyle(
                                              color: AppColor.grey,
                                              fontWeight: FontWeight.w200),
                                        ),
                                        TextSpan(
                                          text: product.color,
                                          style: const TextStyle(
                                              color: AppColor.text,
                                          fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontFamily: 'FontMain',
                                          fontSize: 12.sp),
                                      children: [
                                        const TextSpan(
                                          text: 'Size: ',
                                          style:
                                              TextStyle(color: AppColor.grey,
                                              fontWeight: FontWeight.w200),
                                        ),
                                        TextSpan(
                                          text: product.size,
                                          style: const TextStyle(
                                              color: AppColor.text,
                                          fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: AppColor.white,
                                    child: IconButton(
                                      alignment: Alignment.center,
                                      onPressed: () =>
                                          controller.incrementAmount(product),
                                      icon: Icon(
                                        Icons.add,
                                        color: AppColor.icon,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    product.amount.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.text,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'FontMain'),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: AppColor.white,
                                    child: IconButton(
                                      onPressed: () =>
                                          controller.decrementAmount(product),
                                      icon: Icon(
                                        Icons.remove,
                                        color: AppColor.icon,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${product.price}\$',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.text,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'FontMain'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total amount:',
                  style: TextStyle(
                      color: AppColor.grey,
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.w100,
                      fontSize: 14.sp),
                ),
                Text('${controller.calculateTotalAmount().toString() ?? 0}\$'),
              ],
            ),
            10.verticalSpace,
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.all(16.0),
                minimumSize: Size(double.infinity, 0),
              ),
              child: Text(
                'CHECK OUT',
                style: TextStyle(
                  color: AppColor.white,
                  fontFamily: 'FontMain',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
