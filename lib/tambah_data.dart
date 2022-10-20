import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/object.dart';

class Create extends StatefulWidget {
  final Bengkel? bengkel;

  Create({this.bengkel});

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  DbHelper db = DbHelper();

  TextEditingController? motor;
  TextEditingController? kerusakan;
  TextEditingController? sparepart;
  TextEditingController? harga;
  TextEditingController? biaya;
  TextEditingController? total;
  TextEditingController? tanggal;

  @override
  void initState() {
    motor = TextEditingController(
        text: widget.bengkel == null ? '' : widget.bengkel!.motor);

    kerusakan = TextEditingController(
        text: widget.bengkel == null ? '' : widget.bengkel!.kerusakan);

    sparepart = TextEditingController(
        text: widget.bengkel == null ? '' : widget.bengkel!.sparepart);

    harga = TextEditingController(
        text: widget.bengkel == null ? '' : widget.bengkel!.harga);

    biaya = TextEditingController(
        text: widget.bengkel == null ? '' : widget.bengkel!.biaya);

    total = TextEditingController(
        text: widget.bengkel == null ? '' : widget.bengkel!.total);

    tanggal = TextEditingController(
        text: widget.bengkel == null ? '' : widget.bengkel!.tanggal);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 102, 0),
        title: Text('TAMBAH DATA'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: motor,
              decoration: InputDecoration(
                  labelText: 'Motor',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: kerusakan,
              decoration: InputDecoration(
                  labelText: 'Kerusakan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: sparepart,
              decoration: InputDecoration(
                  labelText: 'Sparepart Yang Diganti',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: harga,
              decoration: InputDecoration(
                  labelText: 'Harga Sparepart',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: biaya,
              decoration: InputDecoration(
                  labelText: 'Biaya Servis',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: total,
              decoration: InputDecoration(
                  labelText: 'Total Biaya',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: TextField(
              controller: tanggal,
              decoration: InputDecoration(
                  labelText: 'Tanggal Servis',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 102, 0))),
              child: (widget.bengkel == null)
                  ? Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Perbarui',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertBengkel();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertBengkel() async {
    if (widget.bengkel != null) {
      await db.updateBengkel(Bengkel.fromMap({
        'id': widget.bengkel!.id,
        'motor': motor!.text,
        'kerusakan': kerusakan!.text,
        'sparepart': sparepart!.text,
        'harga': harga!.text,
        'biaya': biaya!.text,
        'total': total!.text,
        'tanggal': tanggal!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      await db.saveBengkel(Bengkel(
        motor: motor!.text,
        kerusakan: kerusakan!.text,
        sparepart: sparepart!.text,
        harga: harga!.text,
        biaya: biaya!.text,
        total: total!.text,
        tanggal: tanggal!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
