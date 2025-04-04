class Item {
  final String? product;
  final int? quantity;
  final int? price;

  Item({required this.product, required this.quantity, required this.price});

  factory Item.fromJson(Map<String,dynamic> jsonData){
    return Item(
      product: jsonData['product'],
      quantity: jsonData['quantity'],
      price: jsonData['price']
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'product': product,
      'quantity': quantity,
      'price': price
    };
  }
}