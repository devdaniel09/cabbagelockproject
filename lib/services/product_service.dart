import 'package:uuid/uuid.dart';
import '../models/product_model.dart';
import '../data/mock_data.dart';

class ProductService {
  static final _uuid = Uuid();

  static List<ProductModel> getAll() {
    return List<ProductModel>.from(MockData.products);
  }

  static void add(ProductModel p) {
    MockData.products.add(p);
  }

  static void delete(String id) {
    MockData.products.removeWhere((p) => p.id == id);
  }

  static ProductModel createNew(String name, int quantity, double price) {
    return ProductModel(
        id: _uuid.v4(), name: name, quantity: quantity, price: price);
  }
}
