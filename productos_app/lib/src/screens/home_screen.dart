import 'package:flutter/material.dart';
import 'package:productos_app/src/models/models.dart';
import 'package:productos_app/src/screens/screens.dart';
import 'package:productos_app/src/services/services.dart';
import 'package:productos_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context);
    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (_, int index) => GestureDetector(
              onTap: () {
                productsService.selectedProduct =
                    productsService.products[index].copy();
                productsService.newPictureFile = null;
                Navigator.pushNamed(context, "product");
              },
              child: ProductCard(
                product: productsService.products[index],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              new Product(available: false, name: '', price: 0);
          productsService.newPictureFile = null;
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
