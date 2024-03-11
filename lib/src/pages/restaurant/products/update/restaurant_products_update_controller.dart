import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:apu_market/src/models/product.dart';
import 'package:apu_market/src/models/response_api.dart';
import 'package:apu_market/src/pages/restaurant/products/home/restaurant_products_home_page.dart';
import 'package:apu_market/src/provider/categories_provider.dart';
import 'package:apu_market/src/models/category.dart';
import 'package:apu_market/src/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RestaurantProductsUpdateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  bool wasLoad = false;

  var idCategory = ''.obs;
  String id = '';
  int quantity = 0;
  List<Category> categories = <Category>[].obs;
  // Agregar la lista productImages
  List<File?> productImages = [];

  ProductsProvider productsProvider = ProductsProvider();
  // Este constructor se llama automáticamente cuando se crea una instancia de la clase
  //llama a la función getCategories para obtener las categorias
  // Luego, limpia la lista categories y la llena con las categorías obtenidas del proveedor.
  RestaurantProductsUpdateController() {
    getCategories();
  }

  loadData(Product product) async {
    if (wasLoad) return;
    nameController.text = product.name ?? '';
    descriptionController.text = product.description ?? '';
    priceController.text = product.price.toString();
    idCategory.value = product.idCategory ?? '';
    id = product.id ?? '';
    quantity = product.quantity ?? 0;
    await imagesToFile(product.image1.toString(), product.image2.toString(),
        product.image3.toString());
    wasLoad = true;
  }

  void getCategories() async {
    print('getCategories');
    var result = await categoriesProvider.getAll();
    print(result);
    categories.clear();
    categories.addAll(result);
  }

  void updateProduct(BuildContext context) async {
    var result =
        await productsProvider.update(Product(), productImages.cast<File>());
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;

    print('NAME: ${name}');
    print('NAME: ${name}');
    print('DESCRIPTION: ${description}');
    print('PRICE: ${price}');
    print('ID CATEGORY: ${idCategory}');
    ProgressDialog progressDialog = ProgressDialog(context: context);
    if (isValidForm(name, description, price)) {
      Product updatedProduct = Product(
          id: id,
          quantity: quantity,
          name: name,
          description: description,
          price: double.parse(price),
          idCategory: idCategory.value);
      progressDialog.show(max: 100, msg: 'Espere un momento...');
      //stream ddart core
      List<File> images = [];
      images.add(imageFile1!);
      images.add(imageFile2!);
      images.add(imageFile3!);
      print("agregue las imagenes");
      Stream stream = await productsProvider.update(updatedProduct, images);
      print(stream);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        print(responseApi);
        if (responseApi.success == true) {
          Get.off(() => RestaurantProductsHomePage());
        }
      });
    }
  }

  bool isValidForm(String name, String description, String price) {
    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingrese el nombre del producto');
      return false;
    }
    if (description.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Ingrese la description del producto');
      return false;
    }
    if (price.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingrese el precio del producto');
      return false;
    }
    if (idCategory.value == '') {
      Get.snackbar('Formulario no valido', 'Seleccione una categoria');
      return false;
    }

    if (imageFile1 == null) {
      Get.snackbar(
          'Formulario no valido', 'Selecciona la imagen1 del producto ');
      return false;
    }
    if (imageFile2 == null) {
      Get.snackbar(
          'Formulario no valido', 'Selecciona la imagen2 del producto ');
      return false;
    }
    if (imageFile3 == null) {
      Get.snackbar(
          'Formulario no valido', 'Selecciona la imagen3 del producto ');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      if (numberFile == 1) {
        imageFile1 = File(image.path);
      } else if (numberFile == 2) {
        imageFile2 = File(image.path);
      } else if (numberFile == 3) imageFile3 = File(image.path);
    }
    update();
  }

  imagesToFile(String imageUrl1, String imageUrl2, String imageUrl3) async {
    if (imageUrl1 != '') {
      final response = await http.get(Uri.parse(imageUrl1));
      final documentDirectory = await getApplicationDocumentsDirectory();

      final file = File('${documentDirectory.path}/image1.png');

      await file.writeAsBytes(response.bodyBytes);
      imageFile1 = file;
    }
    if (imageUrl2 != '') {
      final response = await http.get(Uri.parse(imageUrl2));
      final documentDirectory = await getApplicationDocumentsDirectory();

      final file = File('${documentDirectory.path}/image2.png');

      await file.writeAsBytes(response.bodyBytes);
      imageFile2 = file;
    }
    if (imageUrl3 != '') {
      final response = await http.get(Uri.parse(imageUrl3));
      final documentDirectory = await getApplicationDocumentsDirectory();

      final file = File('${documentDirectory.path}/image3.png');

      await file.writeAsBytes(response.bodyBytes);
      imageFile3 = file;
    }
  }

  void showAlertDialog(BuildContext context, int numberFile) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery, numberFile);
      },
      //border para el boton
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          // side: BorderSide(color: Colors.lightBlue, width: 2.0)
        ),
      ),
      child: Text(
        "GALERIA",
        style: TextStyle(color: Colors.black),
      ),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera, numberFile);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          // side: BorderSide(color: Colors.lightBlue, width: 2.0)
        ),
      ),
      child: Text(
        "CAMARA",
        style: TextStyle(color: Colors.black),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Selecciona una opción",
        style: TextStyle(color: Colors.black),
      ),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory.value = '';
    update();
  }
}
