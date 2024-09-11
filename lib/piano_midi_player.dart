import 'dart:typed_data';

import 'piano_midi_player_platform_interface.dart';

class PianoMidiPlayer {
  Future<void> playMidi(String midiURL) async {
    return PianoMidiPlayerPlatform.instance.playMidi(midiURL);
  }

  Future<void> playMidiData(Uint8List data) async {
    return PianoMidiPlayerPlatform.instance.playMidiData(data);
  }

  Future<void> stopMidi() async {
    return PianoMidiPlayerPlatform.instance.stopMidi();
  }
}
