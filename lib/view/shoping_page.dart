import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/controller/cart_controller.dart';
import 'package:online_shop/controller/shoping_controller.dart';
import 'package:get/get.dart';
import 'package:online_shop/model/product.dart';

class ShopingPage extends StatelessWidget {
  final shopingController = Get.put(ShopingController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          icon: Icon(
            Icons.add_shopping_cart,
            color: Colors.black,
          ),
          label: GetX<CartController>(builder: (CartController) {
            return Text(
              cartController.countItem.toString(),
              style: TextStyle(fontSize: 24),
            );
          })),
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          Expanded(
            child: GetX<ShopingController>(
              builder: (shopingController) {
                return ListView.builder(
                  itemCount: shopingController.product.length,
                  itemBuilder: (context, index) => Card(
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${shopingController.product[index].productName}',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                      '${shopingController.product[index].productDescription}'),
                                ],
                              ),
                              Text(
                                  '\$${shopingController.product[index].price}',
                                  style: TextStyle(fontSize: 24)),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              cartController.addCartItem(
                                  shopingController.product[index]);
                            },
                            child: Container(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                          GetX<ShopingController>(builder: (ShopingController) {
                            return IconButton(
                                onPressed: () {
                                  shopingController.product[index].isFavorite
                                      .toggle();
                                },
                                icon: shopingController
                                        .product[index].isFavorite.value
                                    ? Icon(Icons.check_box)
                                    : Icon(Icons
                                        .check_box_outline_blank_outlined));
                          })

                          // Obx(
                          //   () => IconButton(
                          //     icon: shopingController
                          //             .product[index].isFavorite.value
                          //         ? Icon(Icons.check_box_rounded)
                          //         : Icon(
                          //             Icons.check_box_outline_blank_outlined),
                          //     onPressed: () {
                          //       shopingController.product[index].isFavorite
                          //           .toggle();
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          GetX<CartController>(builder: (cartController) {
            return Text(
              'Total Amount: \$${cartController.totalPrice}',
              style: TextStyle(fontSize: 32, color: Colors.black),
            );
          }),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
