import 'package:canteen_owner_app/model/customer_model.dart';
import 'package:canteen_owner_app/model/order_model.dart';

class UserOrder{
  final int quantity;
  final String product_name;
  final String canteen_id;

  UserOrder(this.quantity, this.product_name, this.canteen_id);

  UserOrder.fromMap(Map<String,dynamic>map)
      :quantity=map['quantity'] ?? 0,
        product_name=map['product_name'] ?? '',
        canteen_id = map['canteen_id'] ?? '';


  @override
  String toString() => "Record<$quantity:$product_name:$canteen_id>";

}