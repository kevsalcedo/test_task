import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:test_task/utils/display_constants.dart';

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
        _changeColorBackground2();
        _checkSoundMode();
      },
      child: MaterialApp(
        title: kAppTitle,
        theme: ThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          colorScheme:
              isDarkMode ? const ColorScheme.dark() : const ColorScheme.light(),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(kAppTitle),
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
              kHeyThere,
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
                kSettings,
                style: TextStyle(
                  fontSize: kHeadlineType1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text(
                      kSelectColors,
                      style: TextStyle(
                        fontSize: kHeadlineType2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioListTile<ColorMode>(
                      title: const Text(kPartyMode),
                      value: ColorMode.partyMode,
                      groupValue: _colorGroup,
                      onChanged: (ColorMode? value) {
                        setState(() => _colorGroup = value);
                      },
                    ),
                    RadioListTile<ColorMode>(
                      title: const Text(kWormMode),
                      value: ColorMode.warmMode,
                      groupValue: _colorGroup,
                      onChanged: (ColorMode? value) {
                        setState(() => _colorGroup = value!);
                      },
                    ),
                    RadioListTile<ColorMode>(
                      title: const Text(kColdMode),
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
                      kEnableOptions,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SwitchListTile(
                      title: const Text(kSound),
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
                        kDarkMode,
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

  /// Generate random cold colors for background taking into account the parameters
  void _useRandom(int red, int green, int blue) {
    setState(() {
      _backgroundColor = Color.fromRGBO(
        Random().nextInt(red),
        Random().nextInt(green),
        Random().nextInt(blue),
        1,
      );
    });
  }

  /// Change the background color taking into account the _colorGroup selected by the user.
  void _changeColorBackground2() {
    if (_colorGroup == ColorMode.partyMode) {
      _useRandom(256, 256, 256);
    } else if (_colorGroup == ColorMode.warmMode) {
      _useRandom(256, 128, 64);
    } else {
      _useRandom(64, 128, 256);
    }
  }

  /// Play sound if isSoundActive is true
  void _checkSoundMode() {
    if (isSoundActive == true) {
      player.setSource(AssetSource(kNote1));
      player.resume();
      player.seek(const Duration(milliseconds: kSoundDuration));
    }
  }
}
