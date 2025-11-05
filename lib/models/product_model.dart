class ProductModel {
  final String id;
  String name;
  int quantity;
  double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        quantity: json['quantity'] ?? 0,
        price: (json['price'] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'price': price,
      };
}
