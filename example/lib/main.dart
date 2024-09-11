import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piano_midi_player/piano_midi_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MIDI Playback'),
        ),
        body: const MidiPlayer(),
      ),
    );
  }
}

class MidiPlayer extends StatefulWidget {
  const MidiPlayer({super.key});

  @override
  State<MidiPlayer> createState() => _MidiPlayerState();
}

class _MidiPlayerState extends State<MidiPlayer> {
  final _pianoMidiPlayerPlugin = PianoMidiPlayer();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            _pianoMidiPlayerPlugin.playMidi(
              'https://upload.wikimedia.org/wikipedia/commons/5/55/MIDI_sample.mid',
            );
          },
          child: const Text('Play MIDI Url'),
        ),
        ElevatedButton(
          onPressed: () async {
            final response = await http.get(Uri.parse(
                'https://upload.wikimedia.org/wikipedia/commons/5/55/MIDI_sample.mid'));

            if (response.statusCode != 200) {
              debugPrint("Failed to download MIDI: '${response.statusCode}'.");
              return;
            }
            _pianoMidiPlayerPlugin.playMidiData(
              response.bodyBytes,
            );
          },
          child: const Text('Play MIDI Data'),
        ),
        ElevatedButton(
          onPressed: _pianoMidiPlayerPlugin.stopMidi,
          child: const Text('Stop MIDI'),
        ),
      ],
    );
  }
}
