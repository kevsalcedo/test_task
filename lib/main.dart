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

enum ColorMode { partyMode, warmMode, coldMode }

class _MyAppState extends State<MyApp> {
  ColorMode? _colorGroup = ColorMode.partyMode;
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
            int radioColorValue = 0;
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
                      value: ColorMode.partyMode.index,
                      groupValue: _colorGroup,
                      onChanged: (int? value) {
                        setState(() => _colorGroup = value);
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('Warm mode'),
                      value: ColorMode.warmMode.index,
                      groupValue: _colorGroup,
                      onChanged: (int? value) {
                        setState(() => _colorGroup = value!);
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text('Cold mode'),
                      value: ColorMode.coldMode.index,
                      groupValue: _colorGroup,
                      onChanged: (int? value) {
                        setState(() => _colorGroup = value!);
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
