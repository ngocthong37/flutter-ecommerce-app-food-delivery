import 'package:flutter/material.dart';
import 'package:food_delivery/contants/app_contants.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/router_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/exandble_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetai extends StatefulWidget {
  const RecommendedFoodDetai({Key? key, required this.pageId, required this.page})
      : super(key: key);

  final int pageId;
  final String page;

  @override
  State<RecommendedFoodDetai> createState() => _RecommendedFoodDetaiState();
}

class _RecommendedFoodDetaiState extends State<RecommendedFoodDetai> {
  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>()
        .recommedProductList[widget.pageId];
    Get.find<RecommendedProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    if (widget.page == "cartPage") {
                            Get.toNamed(RouteHelper.checkOut);
                          } else {
                            Get.toNamed(RouteHelper.initial);
                          }
                  },
                  child: AppIcon(icon: Icons.clear, color: Colors.grey)),
              GetBuilder<RecommendedProductController>(
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
                      controller.totalQuantity > 0
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
                                    controller.totalQuantity.toString(),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: Dimensions.height10, bottom: Dimensions.height10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20))),
                child: Center(child: BigText(text: product.name))),
          ),
          pinned: true,
          backgroundColor: AppColors.yellowColor,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.baseUrl + '/uploads/' + product.img)),
        ),
        SliverToBoxAdapter(
            child: Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height10),
          child: ExandbleText(
              text:
                  'Donald Trump has accelerated his campaign planning, hoping a White House bid will blunt a series of damaging revelations. Some Republicans are worried. Chicken marinented in a spiced yoghur is placed in a large pot, then layered with fired onions(cheeku easy sub below!), fresh conriander/ciliantro, thn par boiled lightly spiced rice. The crowning glory is to finish it off with a drizzle of saffron infused water to give it the signature pathches of bright yellow. Donald Trump has accelerated his campaign planning, hoping a White House bid will blunt a series of damaging revelations. Some Republicans are worried. Chicken marinented in a spiced yoghur is placed in a large pot, then layered with fired onions(cheeku easy sub below!), fresh conriander/ciliantro, thn par boiled lightly spiced rice. The crowning glory is to finish it off with a drizzle of saffron infused water to give it the signature pathches of bright yellow. Donald Trump has accelerated his campaign planning, hoping a White House bid will blunt a series of damaging revelations. Some Republicans are worried. Chicken marinented in a spiced yoghur is placed in a large pot, then layered with fired onions(cheeku easy sub below!), fresh conriander/ciliantro, thn par boiled lightly spiced rice. The crowning glory is to finish it off with a drizzle of saffron infused water to give it the signature pathches of bright yellow. Donald Trump has accelerated his campaign planning, hoping a White House bid will blunt a series of damaging revelations. Some Republicans are worried. Chicken marinented in a spiced yoghur is placed in a large pot, then layered with fired onions(cheeku easy sub below!), fresh conriander/ciliantro, thn par boiled lightly spiced rice. The crowning glory is to finish it off with a drizzle of saffron infused water to give it the signature pathches of bright yellow. Donald Trump has accelerated his campaign planning, hoping a White House bid will blunt a series of damaging revelations. Some Republicans are worried. Chicken marinented in a spiced yoghur is placed in a large pot, then layered with fired onions(cheeku easy sub below!), fresh conriander/ciliantro, thn par boiled lightly spiced rice. The crowning glory is to finish it off with a drizzle of saffron infused water to give it the signature pathches of bright yellow. Donald Trump has accelerated his campaign planning, hoping a White House bid will blunt a series of damaging revelations. Some Republicans are worried. Chicken marinented in a spiced yoghur is placed in a large pot, then layered with fired onions(cheeku easy sub below!), fresh conriander/ciliantro, thn par boiled lightly spiced rice. The crowning glory is to finish it off with a drizzle of saffron infused water to give it the signature pathches of bright yellow'),
        ))
      ]),
      bottomNavigationBar:
          GetBuilder<RecommendedProductController>(builder: (rcmProduct) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      rcmProduct.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      color: AppColors.mainBlackColor,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                  BigText(
                    text: '\$ ${product.price}  X ' +
                        rcmProduct.quantity.toString(),
                    size: Dimensions.font25,
                  ),
                  GestureDetector(
                    onTap: () {
                      rcmProduct.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      color: AppColors.mainBlackColor,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: AppColors.buttonBackgroundColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      )),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width5, right: Dimensions.width5),
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        rcmProduct.addItem(product);
                      },
                      child: Center(
                        child: BigText(
                          text:
                              '\$ ${product.price * rcmProduct.quantity} | Add to cart',
                          color: Colors.white,
                          size: Dimensions.font15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
