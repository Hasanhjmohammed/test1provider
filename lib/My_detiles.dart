import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test1provider/moduel.dart';
import 'package:toast/toast.dart';
import 'main.dart';

class Mydetiles extends StatelessWidget {
  var name = TextEditingController()..text = "";
  var descrption = TextEditingController()..text = "";
  var price = TextEditingController()..text = "";

  @override
  Widget build(BuildContext context) {
    File image = Provider.of<products>(context, listen: true).image;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (cttt) => MyApp())),
            ),
            title: Text("Add Product"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                TextField(
                  controller: name,
                  decoration:
                      InputDecoration(hintText: "Name", labelText: "Name"),
                  keyboardType: TextInputType.name,
                ),
                TextField(
                  controller: descrption,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "descreption",
                    hintText: "descreption",
                  ),
                ),
                TextField(
                  controller: price,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "descreption",
                    hintText: "Price",
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  color: Colors.pink,
                  child: TextButton(
                    child: Text("add image for your product"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Container(
                            child: Text("Chose image from garary or camera"),
                          ),
                          content: Builder(
                            builder: (ctx) => Container(
                              height: 200,
                              child: Column(
                                children: [
                                  Divider(),
                                  ListTile(
                                    title: Text("galary"),
                                    leading: Icon(Icons.menu),
                                    onTap: () {
                                      context
                                          .read<products>()
                                          .getImage(ImageSource.gallery);
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                    title: Text("galary"),
                                    leading: Icon(Icons.camera_alt_outlined),
                                    onTap: () {
                                      context
                                          .read<products>()
                                          .getImage(ImageSource.camera);
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<products>(
                  builder: (ct, val, chil) => Container(
                    width: double.infinity,
                    height: 50.0,
                    color: Colors.purple,
                    child: TextButton(
                        child: Text("agree"),
                        onPressed: () async {
                          if (name.text == "" ||
                              price.text == "" ||
                              descrption.text == "") {
                            Toast.show(
                              "من فضلك ااملاأ كل الحقول ",
                              ct,
                              duration: 2,
                            );
                          } else if (image == null) {
                            Toast.show(
                              "من فضلك ااملاأ كل الحقول ",
                              ct,
                              duration: 2,
                            );
                          } else {
                            try {
                              val.add(
                                  name: name.text,
                                  dec: descrption.text,
                                  price: price.text);
                              await Navigator.of(ct).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ct) => Home(),
                                ),
                              );
                            } catch (e) {
                              Toast.show(
                                "Hello ",
                                ct,
                                duration: 2,
                              );
                              print(e);
                            }
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          await Toast.show("omclick agen", context, gravity: 2);

          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => MyApp(),
            ),
          );
        });
  }
}
