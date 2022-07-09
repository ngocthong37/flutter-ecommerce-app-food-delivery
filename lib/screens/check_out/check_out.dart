import 'package:flutter/material.dart';
import 'package:food_delivery/contants/app_contants.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/routes/router_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    CartRepo cartRepo;

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CartController>(builder: (controller) {
          var _cartItem = controller.getItems;
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.width10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        color: Colors.white,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.initial);
                      },
                      child: AppIcon(
                          icon: Icons.home_outlined,
                          color: Colors.white,
                          backgroundColor: AppColors.mainColor),
                    ),
                    const Spacer(flex: 1),
                    Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          color: Colors.white,
                          backgroundColor: AppColors.mainColor,
                        ),
                        controller.getTotalQuantity() > 0
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Center(
                                    child: Text(
                                      controller.getTotalQuantity().toString(),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))
                            : Text('')
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10, right: Dimensions.width10),
                      width: double.infinity,
                      height: Dimensions.popularProductCardHeight,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              var popularIndex =
                                  Get.find<PopularProductController>()
                                      .popularProductList
                                      .indexOf(_cartItem[index].product);
                              var rcmIndex =
                                  Get.find<RecommendedProductController>()
                                      .recommedProductList
                                      .indexOf(_cartItem[index].product);
                              if (rcmIndex >= 0) {
                                Get.toNamed(RouteHelper.getRecommededFood(
                                    rcmIndex, "cartPage"));
                              } else if (popularIndex >= 0) {
                                Get.toNamed(RouteHelper.getPopularFood(
                                    popularIndex, "cartPage"));
                              }
                            },
                            child: Container(
                              height: Dimensions.popularProductCardHeight - 25,
                              width: Dimensions.popularProductCardWidth,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                image: DecorationImage(
                                    image: NetworkImage(AppConstants.baseUrl +
                                        '/uploads/' +
                                        _cartItem[index].img!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                top: Dimensions.width10),
                            height: Dimensions.popularProductCardDetail,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: _cartItem[index].name.toString(),
                                  color: AppColors.mainBlackColor,
                                ),
                                SizedBox(height: Dimensions.height5),
                                SmallText(
                                  text: 'Spicy',
                                  color: Colors.grey,
                                ),
                                SizedBox(height: Dimensions.height20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                        text:
                                            '\$ ${_cartItem[index].quantity! * _cartItem[index].price!}',
                                        color: Colors.red),
                                    Container(
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.grey),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                controller.removeItem(index);
                                                if (_cartItem[index].quantity ==
                                                    0) {
                                                  controller.removeProduct(
                                                      controller
                                                          .getItems[index].id!,
                                                      index);
                                                }
                                              },
                                              child: const Icon(Icons.remove,
                                                  color: Colors.white)),
                                          BigText(
                                              text: _cartItem[index]
                                                  .quantity
                                                  .toString()),
                                          GestureDetector(
                                            onTap: () {
                                              controller.addNumItem(index);
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                  itemCount: _cartItem.length,
                ),
              )
            ],
          );
        }),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            left: Dimensions.width10, right: Dimensions.width10),
        height: 130,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius15),
                topRight: Radius.circular(Dimensions.radius15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 130,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: GetBuilder<CartController>(
                builder: ((controller) => Center(
                      child: BigText(
                          text: '\$ ${controller.getTotalMoney()}',
                          color: Colors.black),
                    )),
              ),
            ),
            Container(
              width: 130,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: GetBuilder<CartController>(
                  builder: ((controller) => GestureDetector(
                        onTap: () {
                          print("clear cart");
                          controller.saveToStorage();
                          print("${controller.storageItem.length}");
                          controller.addToHistory();
                        },
                        child: Center(
                            child: BigText(
                                text: 'Check Out', color: Colors.white)),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
