import 'dart:convert';
import 'package:api_app/model/productClass.dart';
import 'package:api_app/update_product.dart';
import 'package:flutter/material.dart';
import 'add_new_product.dart';
import 'package:http/http.dart' as http;

import 'network/network_requester.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'API',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductListPojo? productList;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  Future<void> getProduct() async {
    final response = await NetworkRequester().getProductListFromApi();
     if(response['status'] == 'success'){
      productList = ProductListPojo.fromJson(response);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: productList?.listOfProducts?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        productList?.listOfProducts?[index].image ?? ""),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(productList?.listOfProducts?[index].title ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productList?.listOfProducts?[index].brand ??
                          ''),
                      Text(
                        "Price: ${productList?.listOfProducts?[index]
                            .price ?? ''}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    onSelected: (result) {
                      if (result == 0) {
                        String? productId =
                            productList?.listOfProducts?[index].id;
                        NetworkRequester().deleteProduct(productId!);
                        productList!.listOfProducts!;
                      } else {
                        String? productId =
                            productList?.listOfProducts?[index].id;
                        String? productCode =
                            productList?.listOfProducts?[index].title;
                        String? productName =
                            productList?.listOfProducts?[index].title;
                        String? image = productList?.listOfProducts?[index].image;
                        String? unitPrice =
                            productList?.listOfProducts?[index].price;
                        String? productQty =
                            productList?.listOfProducts?[index].shop;
                        String? totalPrice =
                            productList?.listOfProducts?[index].special_price;

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UpdateProduct(
                                  productId: productId,
                                  productCode: productCode,
                                  productName: productName,
                                  img: image,
                                  unitPrice: unitPrice,
                                  qty: productQty,
                                  totalPrice: totalPrice,
                                )));
                      }
                    },
                    itemBuilder: (ctx) =>
                    [
                      const PopupMenuItem(value: 0, child: Text("Delete")),
                      const PopupMenuItem(
                        value: 1,
                        child: Text("Edit"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewProduct()));
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

