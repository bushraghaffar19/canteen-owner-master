import 'package:canteen_owner_app/core/utilities/app_assets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatelessWidget {
  const ProductSlider({super.key});

  static final List<String> images = [
    AppAssets.product1,
    AppAssets.product2,
    AppAssets.product3,
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images
            .map(
              (image) => ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  image,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.fill,
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));
  }
}
