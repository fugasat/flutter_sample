import 'package:flutter/material.dart';
import 'package:flutter_sample/data_model.dart';
import 'package:flutter_sample/data_manager.dart';

class DetailPage extends StatelessWidget {

  DetailPage(this.dataManager, this.dataIndex);
  // final DataModel model;
  final DataManager dataManager;
  final int dataIndex;

  void _removeModel() {
      // setState(() {
      //   dataManager.add();
      // });
      dataManager.models.removeAt(dataIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("次のページ"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(dataManager.models[dataIndex].getName()),
          ),
          TextButton(
            onPressed: () {
              _removeModel();
              Navigator.pop(context);
            },
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }
}