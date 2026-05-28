import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:usedev_uninassau/src/models/product_model.dart';

class ProductService {
  static const _baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> fetchProducts() async {
    final http.Response response;
    try {
      response = await http.get(Uri.parse('$_baseUrl/products'));
    } catch (_) {
      throw Exception('Falha na conexão. Verifique sua internet.');
    }

    if (response.statusCode != 200) {
      throw Exception('Não foi possível carregar os produtos.');
    }

    final List<dynamic> data = json.decode(response.body) as List<dynamic>;
    return data
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
