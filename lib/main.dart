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

  void _useRandomPartyColors() {
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

  void _useRandomWarmColors() {
    setState(() {
      _backgroundColor = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(128),
        Random().nextInt(64),
        1,
      );
    });
  }

  void _useRandomColdColors() {
    setState(() {
      _backgroundColor = Color.fromRGBO(
        Random().nextInt(64),
        Random().nextInt(128),
        Random().nextInt(256),
        1,
      );
    });
  }

  void _changeColorBackground() {
    if (_colorGroup == ColorMode.partyMode) {
      _useRandomPartyColors();
    } else if (_colorGroup == ColorMode.warmMode) {
      _useRandomWarmColors();
    } else {
      _useRandomColdColors();
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            bool soundSwitch = false;
            bool darkModeSwitch = false;

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
                    RadioListTile<ColorMode>(
                      title: const Text('Party mode'),
                      value: ColorMode.partyMode,
                      groupValue: _colorGroup,
                      onChanged: (ColorMode? value) {
                        setState(() => _colorGroup = value);
                      },
                    ),
                    RadioListTile<ColorMode>(
                      title: const Text('Warm mode'),
                      value: ColorMode.warmMode,
                      groupValue: _colorGroup,
                      onChanged: (ColorMode? value) {
                        setState(() => _colorGroup = value!);
                      },
                    ),
                    RadioListTile<ColorMode>(
                      title: const Text('Cold mode'),
                      value: ColorMode.coldMode,
                      groupValue: _colorGroup,
                      onChanged: (ColorMode? value) {
                        setState(() => _colorGroup = value!);
                      },
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 1),
                    const SizedBox(height: 10),
                    const Text(
                      'Enable options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SwitchListTile(
                      title: const Text('Sound'),
                      secondary: const Icon(
                        Icons.volume_up,
                      ),
                      value: soundSwitch,
                      onChanged: (bool value) {
                        setState(() {
                          soundSwitch = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Dark mode',
                      ),
                      secondary: const Icon(
                        Icons.dark_mode,
                      ),
                      value: darkModeSwitch,
                      onChanged: (bool value) {
                        setState(() {
                          darkModeSwitch = value;
                        });
                      },
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
      onTap: _changeColorBackground,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Test task"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _showSettingsDialog();
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
