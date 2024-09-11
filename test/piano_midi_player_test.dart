import 'package:flutter_test/flutter_test.dart';
import 'package:piano_midi_player/piano_midi_player_method_channel.dart';
import 'package:piano_midi_player/piano_midi_player_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPianoMidiPlayerPlatform
    with MockPlatformInterfaceMixin
    implements PianoMidiPlayerPlatform {
  @override
  Future<void> playMidi(String midiURL) async {
    return;
  }

  @override
  Future<void> stopMidi() async {
    return;
  }
}

void main() {
  final PianoMidiPlayerPlatform initialPlatform =
      PianoMidiPlayerPlatform.instance;

  test('$MethodChannelPianoMidiPlayer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPianoMidiPlayer>());
  });
}
