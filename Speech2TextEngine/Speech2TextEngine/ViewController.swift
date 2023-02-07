//
//  ViewController.swift
//  Speech2TextEngine
//
//  Created by pier on 2/2/23.
//

import Cocoa
import AVFoundation
import Speech

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Request microphone access
       

        // Request microphone access
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == .authorized {
                // Start recording audio
                let recognizer = SFSpeechRecognizer()
                let request = SFSpeechAudioBufferRecognitionRequest()
                let node = AVAudioNode()
                
                let recordingFormat = node.outputFormat(forBus: 0)
                node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    request.append(buffer)
                }
                
              
                
                let engine = AVAudioEngine()
                print(engine);
                engine.mainMixerNode;
                engine.prepare()
                try! engine.start()
                
                // Transcribe the recorded audio to text
                recognizer?.recognitionTask(with: request) { result, error in
                    if let result = result {
                        print("Transcribed text: \(result.bestTranscription.formattedString)")
                    }
                    if let error = error {
                        print("Transcription error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
  

   


}

