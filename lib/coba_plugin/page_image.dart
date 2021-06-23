import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PageImage extends StatefulWidget {
  @override
  _PageImageState createState() => _PageImageState();
}

class _PageImageState extends State<PageImage> {
  List<File> listData = [];

  void menuDipilih(String nilai, File f) async {
    if (nilai == 'H') {
      final r = await CoolAlert.show(
          context: context,
          type: CoolAlertType.confirm,
          title: 'Hapus Gambar',
          text: 'Apakah anda yakin ingin hapus gambar ini?',
          onConfirmBtnTap: () => Navigator.pop(context, true));

      if (r == true) {
        listData.remove(f);
        setState(() {});
      }
    }
  }

  Widget item(File f) => ListTile(
        subtitle: Image.file(f),
        title: Column(children: [
          Text('Tanggal File : ${f.lastModifiedSync()}'),
          Text('Ukuran File : ${f.lengthSync()} KB'),
        ]),
        trailing: PopupMenuButton(
            onSelected: (v) => menuDipilih('$v', f),
            itemBuilder: (bc) => [
                  PopupMenuItem(
                    child: Text('Hapus ini'),
                    value: 'H',
                  )
                ]),
      );

  Future<bool> izinCamera() async {
    PermissionStatus statusIzin = await Permission.camera.status;
    if (statusIzin.isGranted == false) {
      statusIzin = await Permission.camera.request();
    }

    return statusIzin.isGranted;
  }

  Widget tombolFloatTambahGambar() => FloatingActionButton(
        onPressed: () async {
          if (await izinCamera() == false) {
            CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                title: 'Akses Kamera',
                text: 'Izin menggunakan kamera tidak diberikan');
            return;
          }

          final pf = await ImagePicker().getImage(source: ImageSource.camera);

          if (pf != null) {
            listData.add(File('${pf.path}'));
            setState(() {});
          }
        },
        child: Icon(Icons.add_a_photo),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: tombolFloatTambahGambar(),
      body: ListView(
        children: [for (var data in listData) item(data)],
      ),
    );
  }
}
