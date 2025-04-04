import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendex_challenge/services/api_service.dart';
import 'package:sendex_challenge/services/auth_service.dart';
import 'package:sendex_challenge/view/order_details_screen.dart';

import '../model/order_model.dart';
import '../viewmodel/orders_viremodel.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    Provider.of<OrdersViewModel>(context).fetchOrder();
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff009788),
        actions: [
          IconButton(
            onPressed: () {
              authService.signOut(context);
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Selector<OrdersViewModel, List<Order>?>(
        selector: (context, ordersViewModel) => ordersViewModel.orders,
        builder: (context, orders, child) {
          return ListView.builder(
            itemCount: orders?.length,
            itemBuilder: (context, i) {
              return Card(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        orders![i].customer.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(orders[i].address.toString()),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Status: ${orders[i].status}"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff009788),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          OrderDetails(order: orders[i]),
                                ),
                              );
                            },
                            child: Text(
                              "Details",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
