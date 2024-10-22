class Product {
  final String name;
  final String description;
  final double? price;
  final List<String>? colors;

  Product({required this.name, required this.description, this.price, this.colors});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'] ?? 'No description available',
      price: double.tryParse(json['price'] ?? '0.0'),
      colors: (json['product_colors'] as List?)
          ?.map((color) => color['colour_name'] as String)
          .toList(),
    );
  }
}
