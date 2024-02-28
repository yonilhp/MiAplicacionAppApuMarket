import 'package:apu_market/src/models/category.dart';
import 'package:apu_market/src/models/product.dart';
import 'package:apu_market/src/provider/categories_provider.dart';
import 'package:apu_market/src/provider/products_provider.dart';
import 'package:get/get.dart';

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
}
