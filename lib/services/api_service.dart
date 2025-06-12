import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final products = (jsonData['data'] as List)
          .map((item) => Product.fromJson(item))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
