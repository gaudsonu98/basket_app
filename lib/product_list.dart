import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:basket_app/cart_model.dart';
import 'package:basket_app/cart_provider.dart';
import 'package:basket_app/cart_screen.dart';
import 'package:basket_app/db_helper.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {


  DBHelper? dbHelper = DBHelper();
  List<String> productName = ['Apple' , 'Banana' , 'Grapes' , 'Kiwi' , 'Orange' , 'Pineapple','Water Melon'] ;
  List<String> productUnit = ['KG' , 'Dozen' , 'KG' , 'KG' , 'KG' , 'KG','KG',] ;
  List<int> productPrice = [100, 40 , 80 , 150 , 70, 60 , 65 ] ;
  List<String> productImage = [
    'apple.png' ,
    'banana.png' ,
    'grapes.png' ,
    'kiwi.png' ,
    'orange.png' ,
    'pineapple.png' ,
    'watermelon.png' ,
  ] ;
  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
            },
            child: Center(
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child){
                    return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white));
                },

        ),
                animationDuration: Duration(milliseconds: 300),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(width: 20.0)
        ],

      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: productName.length,
              itemBuilder: (context,index){
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image(
                          height: 100,
                          width: 100,
                          image:AssetImage("assets/" + productImage[index].toString()),

                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(productName[index].toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5,),
                          Text(r"₹" +productPrice[index].toString()+" | "+productUnit[index].toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5,),
                         Align(
                           alignment: Alignment.centerRight,
                           child: InkWell(
                             onTap: (){
                               dbHelper!.insert(
                                 Cart(
                                     id: index,
                                     productId: index.toString(),
                                     productName: productName[index].toString(),
                                     initialPrice: productPrice[index],
                                     productPrice: productPrice[index],
                                     quantity: 1,
                                     unitTag: productUnit[index].toString(),
                                     image: productImage[index].toString())
                               ).then((value) {

                                 cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                 cart.addCounter();
                                 print('Product is added to cart');
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(content: Text("Product Added"))
                                 );
                               }
                               ).onError((error, stackTrace) {
                                 print(error.toString());
                               }
                               );
                             },
                            child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text('Add to Cart',style: TextStyle(color: Colors.white),),
                            ),
                          )))
                        ],))


                      ],

                    )
                  ],
                ),
              ),
            );
          }),
          ),

        ],
      ),
    );
  }
}




