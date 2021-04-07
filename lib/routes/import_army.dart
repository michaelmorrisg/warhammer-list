import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'dart:convert';

class ImportArmy extends StatefulWidget {
  final Map army;
  const ImportArmy({Key key, @required this.army}) : super(key: key);
  _ImportArmyState createState() => _ImportArmyState();
}

class _ImportArmyState extends State<ImportArmy> {
  List selectedItemList;

  @override
  void initState() {
    http.get('http://192.168.0.15:3000/testing').then((response) {
      var unparsedXml = jsonDecode(response.body)['xml'];
      final parsedXml = XmlDocument.parse(unparsedXml);
      final catalogue = parsedXml.getElement('catalogue');
    });
  }


  Widget build(BuildContext context) {
    print(widget.army);
    return Scaffold(
      appBar: AppBar(title: Text('Import ${widget.army['title']}')),
      body: Text('Hey there!')
    );
  }
}

                // var response = await http.get('http://192.168.0.15:3000/testing');
                // var unparsedXml = jsonDecode(response.body)['xml'];
                // final parsedXml = XmlDocument.parse(unparsedXml);
                // final catalogue = parsedXml.getElement('catalogue');
                // final entries = catalogue.getElement('sharedSelectionEntries').getElement('selectionEntry').attributes;
                // List entries = units.map((entry) => entry).toList();
                // units.map((node) => node.text).forEach(print);
                // print(entries[0]);
                // print(entries);
