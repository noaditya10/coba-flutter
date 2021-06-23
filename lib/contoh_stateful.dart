import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContohStateful extends StatefulWidget {
  @override
  _ContohStatefulState createState() => _ContohStatefulState();
}

class _ContohStatefulState extends State<ContohStateful> {
  String keadaan = '';

  Widget tampilan() {
    if (keadaan == 'loading')
      return CupertinoActivityIndicator();
    else if (keadaan == 'finish')
      return Icon(CupertinoIcons.flag_fill, size: 50);

    return Text('Belum ada keadaan');
  }

  Widget tombolGantiKeadaan(String nilai) => ElevatedButton(
      onPressed: () {
        setState(() {
          keadaan = '$nilai';
        });
      },
      child: Text('Ganti keadaan "$nilai"'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contoh stateful widget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          tampilan(),
          tombolGantiKeadaan('loading'),
          tombolGantiKeadaan('finish'),
          tombolGantiKeadaan('')
        ],
      ),
    );
  }
}
