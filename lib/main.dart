import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
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

enum ColorMode {
  partyMode,
  warmMode,
  coldMode,
}

class _MyAppState extends State<MyApp> {
  ColorMode? _colorGroup = ColorMode.partyMode;
  Color _backgroundColor = Colors.red;
  final player = AudioPlayer();
  bool isSoundActive = false;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _changeColorBackground();
        _checkSoundMode();
      },
      child: MaterialApp(
        title: 'Test task',
        theme: ThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          colorScheme:
              isDarkMode ? const ColorScheme.dark() : const ColorScheme.light(),
        ),
        home: Scaffold(
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
                //color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Show the settings dialog
  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                      value: isSoundActive,
                      onChanged: (bool value) {
                        setState(() {
                          isSoundActive = value;
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
                      value: isDarkMode,
                      onChanged: (bool value) {
                        setState(() {
                          isDarkMode = value;
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

  /// Generate random color for background
  void _useRandomPartyColors() {
    setState(() {
      _backgroundColor = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1,
      );
    });
  }

  /// Generate random warm colors for background
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

  /// Generate random cold colors for background
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

  /// Change the background color taking into account the _colorGroup selected by the user.
  void _changeColorBackground() {
    if (_colorGroup == ColorMode.partyMode) {
      _useRandomPartyColors();
    } else if (_colorGroup == ColorMode.warmMode) {
      _useRandomWarmColors();
    } else {
      _useRandomColdColors();
    }
  }

  /// Play sound if isSoundActive is true
  void _checkSoundMode() {
    if (isSoundActive == true) {
      player.setSource(AssetSource('note1.wav'));
      player.resume();
      player.seek(const Duration(milliseconds: 1200));
    }
  }
}
