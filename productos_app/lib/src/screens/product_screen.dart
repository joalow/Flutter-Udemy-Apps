import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/src/providers/product_form_provider.dart';
import 'package:productos_app/src/services/product_service.dart';
import 'package:productos_app/src/ui/input_decorations.dart';
import 'package:productos_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final producService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(producService.selectedProduct),
        child: _ProductScreen(productService: producService));
  }
}

class _ProductScreen extends StatelessWidget {
  const _ProductScreen({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.picture),
                Positioned(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 30),
                  ),
                  top: 60,
                  left: 20,
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () async {
                      final picker = new ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 100);

                      if (pickedFile == null) {
                        print("No seleccciono ninguna imagen!");
                        return;
                      }
                      print("Tenemos la imagen ${pickedFile.path}");
                      productService
                          .updateSelectedProductImage(pickedFile.path);
                    },
                    icon: Icon(Icons.camera_alt_outlined,
                        color: Colors.white, size: 30),
                  ),
                  top: 60,
                  right: 20,
                )
              ],
            ),
            _ProductForm(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.save_alt_outlined),
        onPressed: () async {
          if (!productForm.isValidForm()) return;
          final String? imageUrl = await productService.uploadImage();
          if (imageUrl != null) productForm.product.picture = imageUrl;
          await productService.saveOrCreateProduct(productForm.product);
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 7)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: productForm.formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: "Nombre del producto", labelText: "Nombre"),
              ),
              SizedBox(height: 10),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                keyboardType: TextInputType.number,
                initialValue: '${product.price}',
                onChanged: (value) {
                  if (double.tryParse(value) == null)
                    product.price = 0;
                  else
                    product.price = double.parse(value);
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: "\$150", labelText: "Precio"),
              ),
              SizedBox(height: 10),
              SwitchListTile.adaptive(
                value: product.available,
                title: Text("Disponible"),
                onChanged: (value) {
                  productForm.updateAvailability(value);
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
