import 'package:enove_health2/coba_plugin/page_image.dart';
import 'package:enove_health2/coba_plugin/page_location.dart';
import 'package:enove_health2/coba_plugin/page_qrcode.dart';
import 'package:flutter/material.dart';

class CobaPluginTab extends StatefulWidget {
  @override
  _CobaPluginTabState createState() => _CobaPluginTabState();
}

class _CobaPluginTabState extends State<CobaPluginTab>
    with TickerProviderStateMixin {
  late TabController _tabController;

  _CobaPluginTabState() {
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coba Plugins'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Gambar',
              icon: Icon(Icons.image),
            ),
            Tab(
              text: 'Lokasi',
              icon: Icon(Icons.pin_drop),
            ),
            Tab(
              text: 'QRCode',
              icon: Icon(Icons.qr_code),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PageImage(),
          PageLokasi(),
          PageQRCode(),
        ],
      ),
    );
  }
}
