import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/contants/app_contants.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/routes/router_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPage = 0.0;
  final double _scaleFactor = 0.8;
  double height = Dimensions.pageViewController;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // slider section
      GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return popularProduct.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProduct.popularProductList.length,
                      itemBuilder: ((context, index) {
                        return _buildPageItem(
                            index, popularProduct.popularProductList[index]);
                      })),
                )
              : CircularProgressIndicator();
        },
      ),
      // dot
      GetBuilder<PopularProductController>(builder: (popularProduct) {
        var dotCount = popularProduct.popularProductList.length;
        return DotsIndicator(
          dotsCount: dotCount <= 0 ? 1 : dotCount,
          position: _currentPage,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.grey, // Inactive color
            activeColor: AppColors.mainColor,
          ),
        );
      }),
      // popular Text
      SizedBox(height: Dimensions.height30),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BigText(text: 'Recommended'),
            SizedBox(width: Dimensions.width10),
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: SmallText(
                  text: '.',
                  color: Colors.grey,
                )),
            SizedBox(width: Dimensions.width10),
            Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: 'Food paring',
                  color: Colors.grey,
                ))
          ],
        ),
      ),
      GetBuilder<RecommendedProductController>(
        builder: (recommededProduct) {
          var recommmededList = recommededProduct.recommedProductList;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommededProduct.recommedProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getRecommededFood(index, "home"));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: Dimensions.width10,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: Row(
                    children: [
                      Container(
                        height: Dimensions.popularProductCardHeight,
                        width: Dimensions.popularProductCardWidth,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image: DecorationImage(
                                image: NetworkImage(AppConstants.baseUrl +
                                    '/uploads/' +
                                    recommmededList[index].img),
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                        child: Container(
                          height: Dimensions.popularProductCardDetail,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20))),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: recommmededList[index].name),
                                SizedBox(
                                  height: Dimensions.height15,
                                ),
                                SmallText(
                                  text: 'With chinese chareteric',
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                Row(
                                  children: [
                                    IconAndText(
                                        text: 'Normal',
                                        size: 12,
                                        icon: Icons.circle_sharp,
                                        iconColor: Colors.grey),
                                    IconAndText(
                                        text: '1.7 km',
                                        size: 12,
                                        icon: Icons.location_on,
                                        iconColor: AppColors.mainColor),
                                    IconAndText(
                                        text: '32 min',
                                        size: 12,
                                        icon: Icons.access_time_rounded,
                                        iconColor: Colors.red),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      )
    ]);
  }

  Widget _buildPageItem(int index, ProductModel productElement) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPage.floor()) {
      var curScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var curTrans = height * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1);
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else if (index == _currentPage.floor() + 1) {
      var curScale =
          _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
      var curTrans = height * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else if (index == _currentPage.floor() - 1) {
      var curScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      var curTrans = height * (1 - curScale) / 2;
      matrix = Matrix4.diagonal3Values(1, curScale, 1);
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else {
      var curScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, curScale, 1)
        ..setTranslationRaw(0, height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(index, "home"));
          },
          child: Container(
            height: Dimensions.pageViewController,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                    image: NetworkImage(AppConstants.baseUrl +
                        "/uploads/" +
                        productElement.img),
                    fit: BoxFit.cover)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height20),
            padding: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: productElement.name),
                SizedBox(height: Dimensions.height5),
                Row(
                  children: [
                    ...List.generate(
                        5,
                        (index) => Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                              size: 15,
                            )),
                    SizedBox(width: Dimensions.width8),
                    SmallText(
                        text: productElement.stars.toString(),
                        color: Colors.grey),
                    SizedBox(width: Dimensions.width8),
                    SmallText(
                      text: "1280",
                      color: Colors.grey,
                    ),
                    SmallText(
                      text: " comments",
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconAndText(
                      size: 15,
                      text: 'Normal',
                      icon: Icons.circle_sharp,
                      iconColor: Colors.grey),
                    IconAndText(
                      size: 15,
                      text: '1.7 km',
                      icon: Icons.location_on,
                      iconColor: AppColors.mainColor),
                    IconAndText(
                      size: 15,
                      text: '32 min',
                      icon: Icons.access_time_rounded,
                      iconColor: Colors.red),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
