import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'piano_midi_player_platform_interface.dart';

/// An implementation of [PianoMidiPlayerPlatform] that uses method channels.
class MethodChannelPianoMidiPlayer extends PianoMidiPlayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('piano_midi_player');

  @override
  Future<void> playMidi(String midiURL) async {
    try {
      final result =
          await methodChannel.invokeMethod('playMidi', {'midiPath': midiURL});
      print(result);
    } on PlatformException catch (e) {
      debugPrint("Failed to play MIDI: '${e.message}'.");
    }
  }

  @override
  Future<void> stopMidi() async {
    try {
      await methodChannel.invokeMethod('stopMidi');
    } on PlatformException catch (e) {
      debugPrint("Failed to stop MIDI: '${e.message}'.");
    }
  }
}
