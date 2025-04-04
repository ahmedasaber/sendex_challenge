import 'package:flutter/cupertino.dart';
import 'package:sendex_challenge/services/api_service.dart';

import '../model/order_model.dart';

class OrdersViewModel extends ChangeNotifier{
  List<Order>? _ordersList = [];

  Future<void> fetchOrder() async{
    _ordersList = await OrdersApi().fetchOrders();
    notifyListeners();
  }

  List<Order>? get orders => _ordersList;

}