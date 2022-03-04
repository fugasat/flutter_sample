import 'package:flutter/material.dart';
import 'package:flutter_sample/data_model.dart';

class DetailPage extends StatelessWidget {

  DetailPage(this.model);
  final DataModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("次のページ"),
      ),
      body: Container(
        child: Text(model.getName()),
      ),
    );
  }
}