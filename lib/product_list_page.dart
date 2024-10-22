import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/models/product_model.dart';


class ProductListPage extends StatefulWidget {
  final String brand;

  ProductListPage({required this.brand});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('http://makeup-api.herokuapp.com/api/v1/products.json?brand=${widget.brand}'));

    if (response.statusCode == 200) {
      final List productsJson = json.decode(response.body);
      setState(() {
        products = productsJson.map((json) => Product.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products by ${widget.brand}')),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(products[index].description),
                        SizedBox(height: 8),
                        Text('Price: \$${products[index].price?.toStringAsFixed(2) ?? 'N/A'}'),
                        if (products[index].colors != null && products[index].colors!.isNotEmpty)
                          Wrap(
                            children: products[index].colors!
                                .map((color) => Container(
                                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(color),
                                    ))
                                .toList(),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
