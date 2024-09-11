import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piano_midi_player/piano_midi_player_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelPianoMidiPlayer platform = MethodChannelPianoMidiPlayer();
  const MethodChannel channel = MethodChannel('piano_midi_player');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('playMidi', () async {
    await platform.playMidi('midi');
  });
}
