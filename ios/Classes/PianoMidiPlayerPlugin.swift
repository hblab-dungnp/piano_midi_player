import Flutter
import UIKit
import AVFoundation

public class PianoMidiPlayerPlugin: NSObject, FlutterPlugin {
    var midiPlayer: AVMIDIPlayer?
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "piano_midi_player", binaryMessenger: registrar.messenger())
        let instance = PianoMidiPlayerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "playMidi":
            if let midiURL = call.arguments as? String {
                self.playMidi(midiURL: midiURL, result: result)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
            }
        case "playMidiData":
            if let midiData = call.arguments as? FlutterStandardTypedData {
                self.playMidi(data: midiData.data, result: result)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
            }
        case "stopMidi":
            self.stopMidi()
            result("Stopped MIDI")
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func playMidi(midiURL: String, result: @escaping FlutterResult) {
        // Load Sound Bank file
        guard let soundBankURL = Bundle(for: type(of: self)).url(forResource: "UprightPianoKW-20190703", withExtension: "sf2") else {
            result(FlutterError(code: "INVALID_URL", message: "Sound bank file not found", details: nil))
            return
        }
        
        guard let midiFileURL = URL(string: midiURL) else {
            result(FlutterError(code: "INVALID_URL", message: "Invalid midi file URL", details: nil))
            return
        }
        
        // Download MIDI file
        downloadFile(from: midiFileURL) { [weak self] midiLocalURL in
            guard let midiLocalURL = midiLocalURL else {
                result(FlutterError(code: "DOWNLOAD_FAILED", message: "Failed to download MIDI file", details: nil))
                return
            }
            
            do {
                self?.midiPlayer?.stop()
                self?.midiPlayer = try AVMIDIPlayer(contentsOf: midiLocalURL, soundBankURL: soundBankURL)
                self?.midiPlayer?.prepareToPlay()
                self?.midiPlayer?.play()
                result("Playing MIDI")
            } catch {
                result(FlutterError(code: "PLAYER_ERROR", message: "Failed to create AVMIDIPlayer: \(error.localizedDescription)", details: nil))
            }
        }
    }
    
    func playMidi(data: Data, result: @escaping FlutterResult) {
        // Load Sound Bank file
        guard let soundBankURL = Bundle(for: type(of: self)).url(forResource: "UprightPianoKW-20190703", withExtension: "sf2") else {
            result(FlutterError(code: "INVALID_URL", message: "Sound bank file not found", details: nil))
            return
        }

        do {
            self.midiPlayer?.stop()
            self.midiPlayer = try AVMIDIPlayer(data: data, soundBankURL: soundBankURL)
            self.midiPlayer?.prepareToPlay()
            self.midiPlayer?.play()
            result("Playing MIDI")
        } catch {
            result(FlutterError(code: "PLAYER_ERROR", message: "Failed to create AVMIDIPlayer: \(error.localizedDescription)", details: nil))
        }
    }
    
    func stopMidi() {
        midiPlayer?.stop()
    }
    
    func downloadFile(from url: URL, completion: @escaping (URL?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { tempLocalURL, response, error in
            if let tempLocalURL = tempLocalURL {
                completion(tempLocalURL)
            } else {
                print("Error downloading file: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
        task.resume()
    }
}
