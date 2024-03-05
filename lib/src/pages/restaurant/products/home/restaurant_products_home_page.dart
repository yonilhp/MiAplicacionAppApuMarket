import 'package:apu_market/src/models/category.dart';
import 'package:apu_market/src/models/product.dart';
import 'package:apu_market/src/pages/restaurant/products/home/restaurant_products_home_controller.dart';
import 'package:apu_market/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantProductsHomePage extends StatelessWidget {
  RestaurantProductsHomeController con =
      Get.put(RestaurantProductsHomeController());

  @override
  Widget build(BuildContext context) {
    // va recibir la longitud de cuantas categorias va recibir
    return Obx(() => DefaultTabController(
          length: con.categories.length,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                bottom: TabBar(
                    isScrollable: true,
                    indicator:
                        BoxDecoration(color: Color.fromARGB(235, 72, 184, 192)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: List<Widget>.generate(con.categories.length, (index) {
                      return Tab(
                        child: Text(con.categories[index].name ?? ''),
                      );
                    })),
              ),
            ),
            body: TabBarView(
              children: con.categories.map((Category category) {
                //Aqui estamos usando un FutureBuilder para mostrar los productos de cada categoria
                return FutureBuilder(
                    future: con.getProducts(category.id ?? '1'),
                    //Usamos AsyncSnapshot para obtener los datos de la lista de productod que va retornar la funcion
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
              }).toList(),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  con.navigateToCreateProductPage();
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                backgroundColor: Color.fromARGB(235, 72, 184, 192),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
          ),
        ));
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return GestureDetector(
      //Aqui estamos usando un GestureDetector para abrir un BottomSheet que va mostrar los detalles del producto
      onTap: () {},
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
                  Row(
                    children: [
                      Text('\$${product.price.toString()}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold)),
                      // icono de borrar productos
                      SizedBox(
                        width: 60,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          con.showAlertDialog(context, product.id ?? '');
                        },
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_square,
                          color: Color.fromARGB(235, 72, 184, 192),
                        ),
                        onPressed: () {
                          //con.deleteProduct(product.id ?? '');
                        },
                      ),
                    ],
                  ),
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
                  //Aqui estamos usando un widget que se llama FadeInImage que nos permite mostrar una imagen mientras carga la imagen definitiva
                  child: FadeInImage(
                      //Aqui estamos usando un operador ternario para verificar si la imagen es nula
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
