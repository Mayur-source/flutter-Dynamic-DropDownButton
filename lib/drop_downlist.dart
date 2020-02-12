import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DropDownList extends StatefulWidget {
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String _selectedItem;

  final String url = 'https://nmayur.000webhostapp.com/get_table_data.php';

  List data = List(); //edited line

  Future<String> getSWData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(response.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Cell Phone Brands"),
      ),
      body: Center(
        child: DropdownButton(
          items: data.map((item) {
            return DropdownMenuItem(
              child: Text(item['cell_phone']),
              value: item['list_id'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _selectedItem = newVal;
            });
          },
          value: _selectedItem,
          hint: Text('Select a Brand'),
        ),
      ),
    );
  }
}
