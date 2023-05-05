import 'package:canteen_owner_app/core/utilities/app_imports.dart';
import 'package:canteen_owner_app/model/product_model.dart';
import 'package:canteen_owner_app/modules/products/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../shared/custom_dialogue.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.grey.shade50,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ===================================================================
              // Image
              // ===================================================================
              Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                  image: DecorationImage(
                    image: NetworkImage(
                      product.image ??'',
                    ),
                    fit: BoxFit.fitWidth,
                  )
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // ===================================================================
              // Title
              // ===================================================================
              Text(
                product.name ??'',
                style: AppFonts.kFont16ptBold,
              ),
              const SizedBox(
                height: 6,
              ),
              // ===================================================================
              // Description
              // ===================================================================
              Text(
                product.description ??'',
                style: AppFonts.kFont12pt,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              // ===================================================================
              // Price
              // ===================================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price: ',
                    style: AppFonts.kFont14pt,
                  ),
                  Text(
                    'Rs. ${product.price}',
                    style: AppFonts.kFont16ptBoldPrimary,
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  UpdateProductScreen(product: product,)));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 3,
                        blurRadius: 20,
                        offset: Offset(0, 15),
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: GestureDetector(
                onTap: (){
                  confirmationDialogue(title: "Confirmation",
                      bodyText: "Are you sure you want to delete the details of product?",
                      function: (){
                        productController.deleteProduct(product.id ??"", context).catchError((e){
                          Navigator.pop(context);
                          customDialogue(
                              title: "Something went wrong",
                              bodyText: e.message.toString(),
                              context: context
                          );
                        });
                      },
                      context: context
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 3,
                        blurRadius: 20,
                        offset: Offset(0, 15),
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
