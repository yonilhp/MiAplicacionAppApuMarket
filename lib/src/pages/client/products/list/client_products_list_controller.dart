import 'package:apu_market/src/models/category.dart';
import 'package:apu_market/src/models/product.dart';
import 'package:apu_market/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:apu_market/src/provider/categories_provider.dart';
import 'package:apu_market/src/provider/products_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController extends GetxController {
  CategoriesProvider categoriesProvider = CategoriesProvider();

  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;

  ClientProductsListController() {
    getCategory();
  }

  void getCategory() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await productsProvider.findByCategory(idCategory);
  }

// Aqui estamos creando la funcion openBottomSheet que va recibir un BuildContext y un Product
  void openBottomSheet(BuildContext context, Product product) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientProductsDetailPage(product: product));
  }
}
