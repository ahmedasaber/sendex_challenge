import 'dart:convert';
import '../model/order_model.dart';
import 'package:http/http.dart' as http;

import '../model/orders_model.dart';

class OrdersApi{

  Future<List<Order>?> fetchOrders() async{
      var response = await http.get(Uri.parse("https://67eeeff6c11d5ff4bf7b5aeb.mockapi.io/Orders"));

      if(response.statusCode == 200){
        var jsonData = jsonDecode(response.body);
        Orders orders = Orders.fromJson(jsonData);
        return orders.ordersList;
  }
      return null;
}

  Future<void> updateOrder(String id, String status) async{
      var response = await http.put(
      Uri.parse("https://67eeeff6c11d5ff4bf7b5aeb.mockapi.io/Orders/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "status": status
        })
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        throw Exception("Failed to update post");
      }
  }
}