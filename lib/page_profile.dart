import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageProfile extends StatelessWidget {
  Widget textProfile() => Text('Profile',
      style: TextStyle(
          fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black54));

  Widget textSelamatDatang() => Text(
        'Selamat Datang',
        style: TextStyle(
            fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
      );

  Widget inputNama() => TextField(
        decoration: InputDecoration(labelText: 'Nama Lengkap'),
      );

  Widget inputAlamat() => TextField(
        decoration: InputDecoration(labelText: 'Alamat'),
        maxLines: 3,
      );

  Widget inputTelp() => TextField(
        decoration: InputDecoration(labelText: 'No.HP/Telp'),
        keyboardType: TextInputType.phone,
      );

  Widget tombolSimpan() =>
      ElevatedButton(onPressed: () {}, child: Text('Simpan'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textProfile(),
              textSelamatDatang(),
              SizedBox(height: 10),
              inputNama(),
              inputAlamat(),
              inputTelp(),
              Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: tombolSimpan(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
