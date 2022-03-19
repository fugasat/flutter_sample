import 'package:flutter/material.dart';
import 'package:flutter_sample/data_model.dart';

class DetailPage extends StatelessWidget {

  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    DataModel result = args as DataModel;

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
            Text(result.getName()),
            TextButton(
              onPressed: () {
                Navigator.pop(context, null); // 元画面への戻り値はnullを設定
              },
              child: const Text('Remove'),
            ),
          ],
        ),
      )
    );
  }
}