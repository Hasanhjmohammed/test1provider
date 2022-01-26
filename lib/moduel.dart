import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class product {
  final String id;
  final String name;
  final String descrption;
  final String  price;
  final File image;

  product({
    @required this.id,
    @required this.name,
    @required this.descrption,
    @required this.price,
    @required this.image,
  });
}

class products with ChangeNotifier {
  List<product> myproducts = [];
  File image;

  void add({String id,String name, String dec, String  price}) {
    final url=Uri.parse("https://shoeapp-f3df4-default-rtdb.firebaseio.com/product.json");
    http.post(url,body: json.encode(
        {
          "id":id,
          "name":name,
          "dec":dec,
          "price":price
        }
    )).then((value) {
print (json.decode(value.body));
myproducts.add(
  product(id:json.decode(value.body)['name']
      , name: name, descrption: dec, price: price, image: image),
);
notifyListeners();
    });


  }
 Future getImage(ImageSource imag)async{

    final pickerfile=await ImagePicker().getImage(source: imag);
    if(pickerfile!=null)
      {image=File(pickerfile.path);
      notifyListeners();
      print ("Select image");}
    else
      print("No Select image ");

}
void delet(String dec){
    myproducts.removeWhere((element) => dec==element.descrption);
    notifyListeners();
}

}
