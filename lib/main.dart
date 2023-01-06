import 'dart:convert';
import 'package:api_app/update_product.dart';
import 'package:flutter/material.dart';
import 'add_new_product.dart';
import 'package:http/http.dart' as http;

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
      home: MyHomePage(title: 'API',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductListPojo? productlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductListFromApi();
  }

  Future<void> getProductListFromApi() async {
    String url = 'https://crud.devnextech.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      productlist = ProductListPojo.fromJson(jsonDecode(response.body));
      setState(() {});
    }
    else{
      print('Failed');
    }
  }

  Future<void> deleteProduct(String productId) async {
    String url = 'https://crud.devnextech.com/api/v1/DeleteProduct/${productId}';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Delete sucessfully')),
      );
    } else {
      print('Failed');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: productlist?.listOfProducts?.length ?? 0,
          itemBuilder: (context, index) {

        return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.car_rental),
              title: Text(productlist?.listOfProducts?[index].productName ?? ''),
              subtitle: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productlist?.listOfProducts?[index].productCode ?? ''),
                    Text("Price: ${productlist?.listOfProducts?[index].totalPrice ?? ''}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              trailing: PopupMenuButton(
                onSelected: (result){
                  if(result ==0){
                    String? product_Id = productlist?.listOfProducts?[index].sId;
                    deleteProduct(product_Id!);
                    getProductListFromApi();

                  }
                  else{
                    String? product_Id = productlist?.listOfProducts?[index].sId;
                    String? product_Code = productlist?.listOfProducts?[index].productCode;
                    String? product_Name = productlist?.listOfProducts?[index].productName;
                    String? image = productlist?.listOfProducts?[index].img;
                    String? unit_Price = productlist?.listOfProducts?[index].unitPrice;
                    String? product_qty = productlist?.listOfProducts?[index].qty;
                    String? total_Price = productlist?.listOfProducts?[index].totalPrice;

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateProduct(productId: product_Id, productCode: product_Code, productName: product_Name, img: image, unitPrice: unit_Price, qty: product_qty, totalPrice: total_Price,)));

                  }
                },

                itemBuilder: (ctx) => [
                  const PopupMenuItem(
                      value: 0,
                      child: Text("Delete")),
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
              MaterialPageRoute(builder: (context) => AddNewProduct()));
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// responsible for the conversion of json to dart
class ProductListPojo {
  String? status;
  List<Product>? listOfProducts;

  ProductListPojo({this.status, this.listOfProducts});

  ProductListPojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfProducts = <Product>[];
      json['data'].forEach((v) {
        listOfProducts!.add(new Product.fromJson(v));
      });
    }
  }
}

class Product {
  String? sId;
  String? productName;
  String? productCode;
  String? img;
  String? unitPrice;
  String? qty;
  String? totalPrice;
  String? createdDate;

  Product(
      {this.sId,
      this.productName,
      this.productCode,
      this.img,
      this.unitPrice,
      this.qty,
      this.totalPrice,
      this.createdDate});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    img = json['Img'];
    unitPrice = json['UnitPrice'];
    qty = json['Qty'];
    totalPrice = json['TotalPrice'];
    createdDate = json['CreatedDate'];
  }
}
