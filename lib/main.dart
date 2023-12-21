import 'package:flutter/material.dart';
import 'package:telephone_directory/detail_page.dart';
import 'package:telephone_directory/person_registration_page.dart';
import 'package:telephone_directory/persons.dart';
import 'package:telephone_directory/persons_D_A_O.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  bool searching_in_progress=false;
  var searchinh_word="";

  Future<List<kisiler>>show_all_person() async {
    var persons_list= await kisiler_D_A_O().show_all_person();

    return persons_list;
  }

  Future<List<kisiler>>show_all_filtered_person(String searching_word) async {
    var persons_list= await kisiler_D_A_O().show_all_filtered_person(searching_word);

    return persons_list;
  }

  Future<void>Delete_person(int kisi_id) async{
    await kisiler_D_A_O().delete_person(kisi_id);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions:[searching_in_progress? IconButton(onPressed: () {setState(() {
          searching_in_progress=false;
          searchinh_word="";
        });}, icon: Icon(Icons.cancel))
            : IconButton(onPressed: () {setState(() {
          searching_in_progress=true;
        });}, icon: Icon(Icons.search))],

        title: searching_in_progress ? TextField(onChanged: (search) {
          setState(() {
            searchinh_word=search;
            print(searchinh_word);
          });
        },
          decoration: InputDecoration(hintText: 'Arama yapınız'),
        ) : Text("Kişiler Listesi"),
      ),
      body: FutureBuilder<List<kisiler>>(
        future:searching_in_progress? show_all_filtered_person(searchinh_word) : show_all_person(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var person_list=snapshot.data;

            return ListView.builder(
              itemCount: person_list!.length,
              itemBuilder: (context, index) {
                var person = person_list[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => detail_page(kisi: person),));
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(person.kisi_ad),
                        Text(person.kisi_tel),
                        IconButton(
                            onPressed: () {Delete_person(person.kisi_id);},
                          icon:Icon(Icons.delete,color: Colors.red,) ,

                        )

                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => person_registration(),));
        },
        tooltip: 'person registration',
        child: const Icon(Icons.add),
      ),
    );
  }
}
