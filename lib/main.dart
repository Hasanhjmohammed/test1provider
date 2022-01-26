import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1provider/moduel.dart';
import 'My_detiles.dart';
import 'package:http/http.dart' as http;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider<products>(create: (_)=>products(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<product> mypro = Provider.of<products>(context,listen: true).myproducts;
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider_Product"),
      ),
      body: mypro.isEmpty
          ? Center(
              child: Text("Nothing is here "),
            )
          : GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                maxCrossAxisExtent: 500.0,
                mainAxisExtent: 200,
               // childAspectRatio: 2,
              ),
              children: mypro
                  .map((item) => Card(
                elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0.0,
                              top: 15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: Image.file(item.image,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fill,),
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20)
                                  )
                                ),
                             
                                width: 150,
                                height: 150,
                                child: Column(
                                  children: [
                                    Text(
                                        " name: ${item.name}\n des: ${item.descrption}\n\n price: ${item.price}\$",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontStyle: FontStyle.italic
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 4,),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(child: FloatingActionButton(
                              heroTag: item.name,
                              child: Icon(Icons.delete),
                              onPressed: ()=>context.read<products>().delet(item.descrption),
                            )),
                          ],
                        ),
                      ),)
                  .toList(),
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.cyanAccent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (c) => Mydetiles(),
                ),
              );
            },
            icon: Icon(Icons.add),
            label: Text("add Products")),
      ),
    );
  }
}
