import 'package:sendex_challenge/model/order_model.dart';

class Orders{
  final List<Order>? ordersList;

  Orders({required this.ordersList});

  factory Orders.fromJson(List<dynamic> jsonData){
    return Orders(
        ordersList: List.of(jsonData).map((e)=>Order.fromJson(e)).toList()
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "orders": ordersList?.map((e)=>e.toJson()).toList()
    };
  }
}