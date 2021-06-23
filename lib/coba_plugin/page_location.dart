import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class PageLokasi extends StatefulWidget {
  @override
  _PageLokasiState createState() => _PageLokasiState();
}

class _PageLokasiState extends State<PageLokasi> {
  Position? lokasiTerkini;
  LatLng? latLngTerkini;
  StreamSubscription? streamLocation;
  Timer? tmr;

  @override
  void initState() {
    super.initState();
    bacaLokasi();
  }

  @override
  void dispose() {
    tmr?.cancel();
    super.dispose();
  }

  Future izinLokasi() async {
    LocationPermission izinLokasi = await Geolocator.checkPermission();

    if (izinLokasi == LocationPermission.denied ||
        izinLokasi == LocationPermission.deniedForever) {
      izinLokasi == await Geolocator.requestPermission();
    }

    return izinLokasi == LocationPermission.always ||
        izinLokasi == LocationPermission.whileInUse;
  }

  void bacaLokasi() async {
    if (await izinLokasi() == false) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Baca Lokasi',
          text: 'Tidak mendapatkan izin membaca lokasi');

      return;
    }
    print('mulai Timer');
    tmr = Timer.periodic(Duration(seconds: 2), (t) async {
      try {
        tmr = t;
        lokasiTerkini = await Geolocator.getCurrentPosition();
        print('lokasi terkini $lokasiTerkini');
        latLngTerkini =
            LatLng(lokasiTerkini?.latitude ?? 0, lokasiTerkini?.longitude ?? 0);
        print('latlng terkini $latLngTerkini');
      } catch (e) {
        print('error $e');
      }
      setState(() {});
    });

    streamLocation =
        Geolocator.getPositionStream(intervalDuration: Duration(seconds: 4))
            .listen((data) {
      lokasiTerkini = data; //simpan lokasiterkini
      //konversi ke objek LatLng
      latLngTerkini =
          LatLng(lokasiTerkini?.latitude ?? 0, lokasiTerkini?.longitude ?? 0);
      setState(() {}); //render ulang
    });
  }

  layerMap() => TileLayerOptions(
      urlTemplate: 'http://{s}.google.com/vt/lyrs=p&x={x}&y={y}&z={z}',
      subdomains: ['mt0', 'mt1', 'mt2', 'mt3']);

  marker() => MarkerLayerOptions(
        markers: [
          Marker(
              width: 45.0,
              height: 45.0,
              point: latLngTerkini ?? LatLng(0, 0),
              builder: (c) => Container(
                  child: Icon(Icons.pin_drop_outlined,
                      color: Colors.green, size: 45)))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return latLngTerkini == null
        ? Center(child: Text('Belum mendapat lokasi'))
        : FlutterMap(
            options:
                MapOptions(center: latLngTerkini ?? LatLng(0, 0), zoom: 17),
            layers: [layerMap(), marker()],
          );
  }
}
