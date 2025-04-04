import 'item_model.dart';

class Order{
  final int? id;
  final String? customer;
  final String? address;
  final List<Item>? items;
  final int? total;
  final String? status;
  final DateTime? orderDate;

  Order({required this.id, required this.customer, required this.address, 
    required this.items, required this.total, required this.status, required this.orderDate});
  
  factory Order.fromJson(Map<String,dynamic> jsonData){
    return Order(
      id: int.parse(jsonData['id']),
      customer: jsonData['customer'], 
      address: jsonData['address'], 
      items: List.of(jsonData['items']).map((e)=>Item.fromJson(e)).toList(),
      total: jsonData['total'], 
      status: jsonData['status'], 
      orderDate: DateTime.parse(jsonData['order_date'])
    );
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "address": address,
    "items": items?.map((x) => x.toJson()).toList(),
    "total": total,
    "status": status,
    "order_date": orderDate?.toIso8601String(),
  };
}