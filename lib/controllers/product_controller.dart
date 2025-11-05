import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductController with ChangeNotifier {
  List<ProductModel> products = [];

  ProductController() {
    products = ProductService.getAll();
  }

  void addProduct(ProductModel p) {
    ProductService.add(p);
    products = ProductService.getAll();
    notifyListeners();
  }

  void removeProduct(String id) {
    ProductService.delete(id);
    products = ProductService.getAll();
    notifyListeners();
  }
}
