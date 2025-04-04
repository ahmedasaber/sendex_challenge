import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendex_challenge/services/api_service.dart';
import 'package:sendex_challenge/viewmodel/orders_viremodel.dart';

import '../model/order_model.dart';

class OrderDetails extends StatelessWidget {
  Order order;

  OrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff009788)),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(top: 10),
        child: ListView(
          itemExtent: 300,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Client Name: ${order.customer}",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Address: ${order.address}",
                  style: TextStyle(fontSize: 18),
                ),
                Wrap(
                  children: [
                    Text("Items: ", style: TextStyle(fontSize: 18)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: order.items?.length,
                      itemBuilder: (context, i) {
                        return Text(
                          "    ${order.items?[i].product}, quantity: ${order.items?[i].quantity}, price: ${order.items?[i].price}",
                          style: TextStyle(fontSize: 18),
                        );
                      },
                    ),
                  ],
                ),
                Text("Total: ${order.total}", style: TextStyle(fontSize: 18)),
                Text(
                  "Date: ${order.orderDate}",
                  style: TextStyle(fontSize: 18),
                ),
                Text("Status: ${order.status}", style: TextStyle(fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff009788),
                  ),
                  onPressed: () {
                    OrdersApi().updateOrder(order.id.toString(), 'Delivered');
                  },
                  child: Text(
                    'Delivered',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    OrdersApi().updateOrder(order.id.toString(), 'Cancelled');
                  },
                  child: Text(
                    'Cancelled',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
            ],
        ),
      ));
  }
}
