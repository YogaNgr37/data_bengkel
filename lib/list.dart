import 'package:flutter/material.dart';
import 'tambah_data.dart';

import 'database/db_helper.dart';
import 'package:flutter_application_1/model/object.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Bengkel> listBengkel = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllBengkel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _openFormCreate();
              },
              icon: Icon(Icons.add_box_sharp))
        ],
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        title: Text("DATA BENGKEL"),
      ),
      body: ListView.builder(
          itemCount: listBengkel.length,
          itemBuilder: (context, index) {
            Bengkel bengkel = listBengkel[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ListTile(
                tileColor: Color.fromARGB(255, 255, 208, 159),
                title: Text(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    '${bengkel.motor}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        'Kerusakan : ${bengkel.kerusakan}\nSparepart Yang Diganti : ${bengkel.sparepart}\nHarga Sparepart : ${bengkel.harga}\nBiaya Servis : ${bengkel.biaya}\nTotal Biaya : ${bengkel.total}\nTanggal : ${bengkel.tanggal}')
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(bengkel);
                          },
                          icon: Icon(Icons.edit)),

                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          AlertDialog hapus = AlertDialog(
                            title: Text("Informasi"),
                            content: Container(
                              height: 30,
                              child: Column(
                                children: [
                                  Text(
                                      "Anda akan menghapus data ${bengkel.motor}")
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteBengkel(bengkel, index);
                                    ;
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> _getAllBengkel() async {
    var list = await db.getAllBengkel();

    setState(() {
      listBengkel.clear();

      list!.forEach((bengkel) {
        listBengkel.add(Bengkel.fromMap(bengkel));
      });
    });
  }

  Future<void> _deleteBengkel(Bengkel bengkel, int position) async {
    await db.deleteBengkel(bengkel.id!);
    setState(() {
      listBengkel.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Create()));
    if (result == 'save') {
      await _getAllBengkel();
    }
  }

  Future<void> _openFormEdit(Bengkel bengkel) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => Create(bengkel: bengkel)));
    if (result == 'update') {
      await _getAllBengkel();
    }
  }
}
