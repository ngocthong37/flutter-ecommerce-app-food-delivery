import 'package:flutter/material.dart';
import 'package:food_delivery/contants/app_contants.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/routes/router_helper.dart';
import 'package:food_delivery/utils/app_column.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/exandble_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  final int pageId;

  final String page;

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: Dimensions.imageHeight,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              AppConstants.baseUrl + '/uploads/' + product.img),
                          fit: BoxFit.cover)),
                ),
              ),
              Positioned(
                left: 20,
                top: 40,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (page == "cartPage") {
                            Get.toNamed(RouteHelper.checkOut);
                          } else {
                            Get.toNamed(RouteHelper.initial);
                          }
                        },
                        child: AppIcon(
                            icon: Icons.arrow_back, color: Colors.black38)),
                    GetBuilder<PopularProductController>(
                      builder: (controller) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.checkOut);
                              },
                              child: AppIcon(
                                  icon: Icons.shopping_cart_outlined,
                                  color: Colors.black38),
                            ),
                            controller.inCartItem > 0
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.mainColor),
                                      child: Center(
                                        child: Text(
                                          controller.inCartItem.toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ))
                                : Text('')
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 270,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height15),
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColum(
                            text: product.name,
                            numOfStar: 4.5,
                            numOfComment: 1280,
                            stateIcon: Icons.circle,
                            locationIcon: Icons.location_on,
                            timeIcon: Icons.access_time_rounded,
                            state: 'Normal',
                            numOfKm: 1.7,
                            time: '32'),
                        SizedBox(height: Dimensions.height20),
                        BigText(text: 'Introduce'),
                        SizedBox(height: Dimensions.height20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ExandbleText(
                              text: product.description,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Container(
            padding: EdgeInsets.only(
                top: Dimensions.height10,
                left: Dimensions.width20,
                right: Dimensions.width20),
            height: 130,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: AppColors.buttonBackgroundColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: const Icon(Icons.remove, color: Colors.grey)),
                      BigText(text: popularProduct.quantity.toString()),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 170,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      popularProduct.addItem(product);
                    },
                    child: Center(
                        child: BigText(
                            text:
                                '\$ ${product.price * popularProduct.quantity} Add to cart',
                            color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
