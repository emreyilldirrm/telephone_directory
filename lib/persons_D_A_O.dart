import 'dart:ffi';

import 'package:telephone_directory/VeritabaniYardimcisi.dart';
import 'package:telephone_directory/persons.dart';

class kisiler_D_A_O {

  Future<List<kisiler>>show_all_person() async {
    var db =await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler");

    return List.generate(maps.length, (index) {
      var satir = maps[index];

      return kisiler(satir["kisi_id"], satir["kisi_ad"], satir["kisi_tel"]);
    });
  }

  Future<List<kisiler>>show_all_filtered_person(String searching_word) async {
    var db =await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler WHERE kisi_ad LIKE '%$searching_word%'");

    return List.generate(maps.length, (index) {
      var satir = maps[index];

      return kisiler(satir["kisi_id"], satir["kisi_ad"], satir["kisi_tel"]);
    });
  }

  Future<void>save_person(String kisi_ad,String kisi_tel) async {
    var db =await VeritabaniYardimcisi.veritabaniErisim();

    var persons=Map<String,dynamic>();
    persons["kisi_ad"]=kisi_ad;
    persons["kisi_tel"]=kisi_tel;

    await db.insert("kisiler", persons);
  }

  Future<void>update_person(int kisi_id,String kisi_ad,String kisi_tel) async {
    var db =await VeritabaniYardimcisi.veritabaniErisim();

    var persons=Map<String,dynamic>();
    persons["kisi_ad"]=kisi_ad;
    persons["kisi_tel"]=kisi_tel;

    await db.update("kisiler",persons, where: "kisi_id=?",whereArgs: [kisi_id]);
  }

  Future<void>delete_person(int kisi_id) async {
    var db =await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("kisiler",where: "kisi_id=?",whereArgs: [kisi_id]);
  }
}