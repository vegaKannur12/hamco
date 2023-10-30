import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({
    Key? key,
    required this.payload,
  }) : super(key: key);

  final String payload;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  TextEditingController _numberCtrl = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _numberCtrl.text = "085921191121";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(widget.payload),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _numberCtrl,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              child: Text("Test Call"),
              onPressed: () async {
                FlutterPhoneDirectCaller.callNumber(_numberCtrl.text);
              },
            )
          ]),
    );
  }
}
