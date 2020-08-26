import 'package:flutter/material.dart';
import 'package:list_tile_edit/editable_list_tile.dart';
import 'package:list_tile_edit/list_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListModel> list = [];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 20; i++)
      list.add(ListModel(title: "Title $i", subTitle: "Subtitle $i"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) => EditableListTile(
            model: list[index],
            onChanged: (ListModel updatedModel) {
              //
              list[index] = updatedModel;
            },
          ),
        ));
  }
}
