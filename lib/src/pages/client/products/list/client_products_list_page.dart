import 'package:apu_market/src/models/category.dart';
import 'package:apu_market/src/models/product.dart';
import 'package:apu_market/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:apu_market/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController con = Get.put(ClientProductsListController());
  //ClientProductsListPage({Key? key}) : super(key: key); // Agregar un constructor con un parámetro nombrado 'key'

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: con.categories.length,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  bottom: TabBar(
                      isScrollable: true,
                      indicator: BoxDecoration(
                          color: Color.fromARGB(235, 72, 184, 192)),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs:
                          List<Widget>.generate(con.categories.length, (index) {
                        return Tab(
                          child: Text(con.categories[index].name ?? ''),
                        );
                      })),
                ),
              ),
              body: TabBarView(
                  children: con.categories.map((Category category) {
                return FutureBuilder(
                    future: con.getProducts(category.id ?? '1'),
                    builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.length > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardProduct(
                                  context, snapshot.data![index]);
                            },
                          );
                        } else {
                          return NoDataWidget(text: 'No hay productos');
                        }
                      } else {
                        // Si no hay datos disponibles, muestra un mensaje
                        return NoDataWidget(text: 'No hay productos');
                      }
                    });
              }).toList())),
        ));
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => con.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              title: Text(product.name ?? '',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              subtitle: Column(
                //Alinear los textos al comienzo
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.description ?? '',
                    maxLines: 2,
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('\$${product.price.toString()}',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              // para mostrar precio
              // Para usar imagen en parte izquierda
              // leading:
              // Para usar imagen en parte derecha se usa :
              trailing: Container(
                height: 70,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                      image: product.image1 != null
                          ? NetworkImage(product.image1!)
                          : AssetImage('assets/img/no-image.png')
                              as ImageProvider,
                      //cover se usa para que tenga un tamaño proporcional las imagenes
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png')),
                ),
              ),
            ),
          ),
          Divider(
              height: 1,
              color: Color.fromARGB(235, 72, 184, 192),
              indent: 37,
              endIndent: 37)
        ],
      ),
    );
  }
}
