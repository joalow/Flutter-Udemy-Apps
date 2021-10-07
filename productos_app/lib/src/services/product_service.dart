import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos_app/src/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl =
      'flutter-udemy-app-edb16-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Product> products = [];
  late Product selectedProduct;

  File? newPictureFile;

  final storage = FlutterSecureStorage();

  bool isLoading = false;
  bool isSaving = false;

  ProductService() {
    this.loadProduct();
  }

  Future loadProduct() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = jsonDecode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;

      this.products.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();

    return this.products;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null)
      await this.createProduct(product);
    else
      await this.updateProduct(product);

    isSaving = false;
    notifyListeners();
  }

  Future updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, "products/${product.id}.json",
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.put(url, body: product.toJson());

    final decodedData = resp.body;
    print(decodedData);

    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }

  Future createProduct(Product product) async {
    final url = Uri.https(_baseUrl, "products.json",
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: product.toJson());

    final decodedData = jsonDecode(resp.body);

    product.id = decodedData['name'];
    this.products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    this.selectedProduct.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/dgtnpbjul/image/upload?upload_preset=FlutterAppTest");
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("Algo salio mal");
      return null;
    }

    final decodedData = json.decode(resp.body);
    return decodedData["secure_url"];
  }
}
