import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _backgroundColor = Colors.red;

  void _changeColor() {
    setState(
      () {
        _backgroundColor = Color.fromRGBO(
          Random().nextInt(256),
          Random().nextInt(256),
          Random().nextInt(256),
          1,
        );
      },
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            int _radioValue = 0;
            bool _switchValue1 = false;
            bool _switchValue2 = false;

            return AlertDialog(
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text(
                      'Select colors',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioListTile<int>(
                      title: const Text('Party mode'),
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: (int? value) {
                        setState(() => _radioValue = value!);
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('Warm colors'),
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: (int? value) {
                        setState(() => _radioValue = value!);
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('Cold colors'),
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: (int? value) {
                        setState(() => _radioValue = value!);
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Enable options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SwitchListTile(
                      title: const Text('Sound'),
                      value: false,
                      onChanged: (bool value) {},
                    ),
                    SwitchListTile(
                      title: const Text('Dark mode'),
                      value: false,
                      onChanged: (bool value) {},
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeColor,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Test task"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _showDialog();
              },
            ),
          ],
        ),
        backgroundColor: _backgroundColor,
        body: const Center(
          child: Text(
            "Hey there",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
