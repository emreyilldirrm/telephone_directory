import 'package:flutter/material.dart';
import 'package:telephone_directory/main.dart';
import 'package:telephone_directory/persons.dart';
import 'package:telephone_directory/persons_D_A_O.dart';

class detail_page extends StatefulWidget {
 kisiler kisi;


 detail_page({required this.kisi});

  @override
  State<detail_page> createState() => _detail_pageState();
}

class _detail_pageState extends State<detail_page> {
  var tfkisi_ad=TextEditingController();
  var tfkisi_tel=TextEditingController();

  Future<void>Update_person(int kisi_id ,String kisi_ad , String kisi_tel) async{
   await kisiler_D_A_O().update_person(kisi_id, kisi_ad, kisi_tel);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
  }

  @override
  void initState() {
    super.initState();
    tfkisi_ad.text=widget.kisi.kisi_ad;
    tfkisi_tel.text=widget.kisi.kisi_tel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Kişiler Listesi"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0,left: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfkisi_ad,
                decoration: InputDecoration(hintText: "Ad Giriniz"),
              ),
              TextField(
                controller: tfkisi_tel,
                decoration: InputDecoration(hintText: "Telefon Giriniz"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        Update_person(widget.kisi.kisi_id, tfkisi_ad.text, tfkisi_tel.text);
        },
        label: Text('Update'),
        icon:  Icon(Icons.update),
      ),
    );

  }
}
