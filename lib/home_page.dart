import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/product_list_page.dart' as productPage;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> brands = [];

  @override
  void initState() {
    super.initState();
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    final response = await http.get(Uri.parse('http://makeup-api.herokuapp.com/api/v1/products.json'));

    if (response.statusCode == 200) {
      final List products = json.decode(response.body);
      Set<String> brandSet = products.map((product) => product['brand']?.toString() ?? 'Unknown').toSet();

      setState(() {
        brands = brandSet.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makeup API App'),
      ),
      body: brands.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom dalam satu baris
                  crossAxisSpacing: 10.0, // Jarak horizontal antar item
                  mainAxisSpacing: 10.0,  // Jarak vertikal antar item
                  childAspectRatio: 2.5,  // Rasio lebar:tinggi item grid
                ),
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3, // Menambahkan bayangan pada Card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Membuat sudut kartu lebih melengkung
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => productPage.ProductListPage(brand: brands[index]),
                          ),
                        );
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            brands[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
