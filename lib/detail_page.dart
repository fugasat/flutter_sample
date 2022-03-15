import 'package:flutter/material.dart';
import 'package:flutter_sample/data_model.dart';
import 'package:flutter_sample/data_manager.dart';

class DetailPage extends StatelessWidget {

  DetailPage(this.model);
  DataModel model;
  DataModel? result = null;

  @override
  Widget build(BuildContext context) {
    result = model;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, result);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("次のページ"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Text(model.getName()),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // 元画面への戻り値はnullを設定
              },
              child: Text('Remove'),
            ),
          ],
        ),
      )
    );
  }
}