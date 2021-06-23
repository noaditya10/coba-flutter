import 'package:barcode_reader/BarcodeScannerView.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PageQRCode extends StatefulWidget {
  @override
  _PageQRCodeState createState() => _PageQRCodeState();
}

class _PageQRCodeState extends State<PageQRCode> {
  bool alertTampil = false;
  bool _izinCamera = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    izinCamera().then((v) {
      setState(() {
        _izinCamera = v;
      });
    });
  }

  Future<bool> izinCamera() async {
    PermissionStatus statusIzin = await Permission.camera.status;

    if (statusIzin.isGranted == false) {
      statusIzin = await Permission.camera.request();
    }

    return statusIzin.isGranted;
  }

  void bacaQR(dynamic data) async {
    if (alertTampil == false) {
      alertTampil = true;

      await CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          title: 'Baca QR',
          text: 'Hasil baca QR : $data');

      alertTampil = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _izinCamera == false
        ? Center(child: Text('Tidak ada izin kamera'))
        : BarcodeScannerView(onBarcodeRead: bacaQR);
  }
}
