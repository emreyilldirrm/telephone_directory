import 'package:flutter/material.dart';
import 'package:telephone_directory/main.dart';
import 'package:telephone_directory/persons_D_A_O.dart';

class person_registration extends StatefulWidget {
  const  person_registration({super.key});

  @override
  State< person_registration> createState() => _person_registrationState();
}

class _person_registrationState extends State< person_registration> {
  var tfkisi_ad=TextEditingController();
  var tfkisi_tel=TextEditingController();

  Future<void>Save_person(String kisi_ad , String kisi_tel) async{
    await kisiler_D_A_O().save_person(kisi_ad, kisi_tel);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Kişi Kayıt Sayfası"),
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
        Save_person(tfkisi_ad.text, tfkisi_tel.text);
        },
        label: Text('Save'),
        icon:  Icon(Icons.add),
      ),
    );;;
  }
}
