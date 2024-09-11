import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'piano_midi_player_method_channel.dart';

abstract class PianoMidiPlayerPlatform extends PlatformInterface {
  /// Constructs a PianoMidiPlayerPlatform.
  PianoMidiPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static PianoMidiPlayerPlatform _instance = MethodChannelPianoMidiPlayer();

  /// The default instance of [PianoMidiPlayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelPianoMidiPlayer].
  static PianoMidiPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PianoMidiPlayerPlatform] when
  /// they register themselves.
  static set instance(PianoMidiPlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> playMidi(String midiURL) async {
    throw UnimplementedError('playMidi() has not been implemented.');
  }

  Future<void> stopMidi() async {
    throw UnimplementedError('stopMidi() has not been implemented.');
  }
}
