import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:test_task/utils/display_constants.dart';
import 'package:test_task/utils/styles.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: MyApp(),
      ),
    ),
  );
}

///
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

/// Represents the different color modes available in the application.
/// Each color mode defines a range of colors that will be used for generate
/// random colors for the background.
enum ColorMode {
  /// Party mode uses a full range of colors.
  partyMode,

  /// The warm mode uses mainly warm colors such as reds and yellows.
  warmMode,

  ///The cool mode uses mainly cool colors such as blues and greens.
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
                fontSize: kFrontTextSize,
                //color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Displays a dialog that allows user to select a color group for background
  /// colors and toggle sound and dark mode
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
                      style: kTextStyle,
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
                        setState(() => _colorGroup = value);
                      },
                    ),
                    RadioListTile<ColorMode>(
                      title: const Text(kColdMode),
                      value: ColorMode.coldMode,
                      groupValue: _colorGroup,
                      onChanged: (ColorMode? value) {
                        setState(() => _colorGroup = value);
                      },
                    ),
                    //const SizedBox(height: 10),
                    const Divider(height: 1),
                    const SizedBox(height: 10),
                    const Text(
                      kEnableOptions,
                      style: kTextStyle,
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

  /// Generate random colors for background taking into account the parameters.
  void _useRandomColors(int red, int green, int blue) {
    setState(() {
      _backgroundColor = Color.fromRGBO(
        Random().nextInt(red),
        Random().nextInt(green),
        Random().nextInt(blue),
        1,
      );
    });
  }

  /// Defines the parameters for the color range depending on the selected _colorGroup.
  void _changeColorBackground() {
    if (_colorGroup == ColorMode.partyMode) {
      _useRandomColors(
        kPartyModeColors.first,
        kPartyModeColors[1],
        kPartyModeColors[2],
      );
    } else if (_colorGroup == ColorMode.warmMode) {
      _useRandomColors(
        kWarmModeColors.first,
        kWarmModeColors[1],
        kWarmModeColors[2],
      );
    } else {
      _useRandomColors(
        kCoolModeColors.first,
        kCoolModeColors[1],
        kCoolModeColors[2],
      );
    }
  }

  /// Play sound if isSoundActive is true.
  void _checkSoundMode() {
    if (isSoundActive == true) {
      player.setSource(AssetSource(kNote1));
      player.resume();
      player.seek(const Duration(milliseconds: kSoundDuration));
    }
  }
}
