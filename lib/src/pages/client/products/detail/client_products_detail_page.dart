import 'package:apu_market/src/models/product.dart';
import 'package:apu_market/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

class ClientProductsDetailPage extends StatelessWidget {
  Product? product;
  ClientProductsDetailController con =
      Get.put(ClientProductsDetailController());

  ClientProductsDetailPage({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(height: 100, child: _buttonsAddToBag()),
        body: Column(
          children: [
            _imageSlideshow(context),
            _textNameProduct(),
            _textDescriptionProduct(),
            _textPriceProduct()
          ],
        ));
  }

  Widget _textNameProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _textDescriptionProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buttonsAddToBag() {
    return Column(
      children: [
        Divider(height: 1, color: Color.fromARGB(235, 72, 184, 192)),
        Container(
          margin: EdgeInsets.only(left: 10, right: 15, top: 25),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '-',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(235, 72, 184, 192),
                  minimumSize: Size(40, 37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                  ),
                ),
              ),
              SizedBox(
                width: 1,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(235, 72, 184, 192),
                  minimumSize: Size(40, 37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                width: 1,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(235, 72, 184, 192),
                  minimumSize: Size(40, 37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Agregar        ${product?.price ?? ''}',
                  style: TextStyle(
                    color: Color.fromARGB(235, 72, 184, 192),
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(180, 37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _textPriceProduct() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30, top: 15, right: 30),
      child: Text(
        '\$ ${product?.price.toString() ?? ''}',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _imageSlideshow(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ImageSlideshow(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.40,
              initialPage: 0,
              indicatorColor: Color.fromARGB(235, 72, 184, 192),
              indicatorBackgroundColor: Colors.grey,
              children: [
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'),
                  image: product!.image1 != null
                      ? NetworkImage(product!.image1!)
                      : AssetImage('assets/img/no-image.png') as ImageProvider,
                ),
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'),
                  image: product!.image2 != null
                      ? NetworkImage(product!.image2!)
                      : AssetImage('assets/img/no-image.png') as ImageProvider,
                ),
                FadeInImage(
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'),
                  image: product!.image3 != null
                      ? NetworkImage(product!.image3!)
                      : AssetImage('assets/img/no-image.png') as ImageProvider,
                ),
              ]),
        ],
      ),
    );
  }
}
