import 'piano_midi_player_platform_interface.dart';

class PianoMidiPlayer {
  Future<void> playMidi(String midiURL) async {
    return PianoMidiPlayerPlatform.instance.playMidi(midiURL);
  }

  Future<void> stopMidi() async {
    return PianoMidiPlayerPlatform.instance.stopMidi();
  }
}
