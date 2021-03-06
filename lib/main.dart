import 'package:flutter/material.dart';
import 'package:flutter_sample/data_manager.dart';
import 'package:flutter_sample/data_model.dart';
import 'package:flutter_sample/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Navigator
      routes: {
        '/': (context) => const MyHomePage(title: 'Model List'),
        '/detail': (context) => DetailPage(),
      },
      initialRoute: "/",
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataManager dataManager = DataManager();

  void _addModel() {
    setState(() {
      dataManager.add();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          itemCount: dataManager.models.length,
          itemBuilder: (context, index) {
            final DataModel model = dataManager.models[index];
            return ListTile(
              title: Text(model.getName()),
              onTap: () async {
                final result = await Navigator.of(context).pushNamed('/detail', arguments: model);
                if (result == null) {
                  setState(() {
                    dataManager.remove(model);
                  });
                } else {
                  setState(() {
                    model.id = (result as DataModel).id;
                  });
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addModel,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
