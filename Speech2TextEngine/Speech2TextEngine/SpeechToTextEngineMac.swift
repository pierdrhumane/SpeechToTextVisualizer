//
//  SpeechToTextEngineMac.swift
//  Speech2TextEngine
//
//  Created by pier on 2/8/23.
//

import Foundation
import AVFoundation
import Accelerate
import Speech

protocol SpeechToTextDelegate: AnyObject {
    func transcriptionUpdated(_ newWord: String);
    func permissionUpdated(_ permissionState:SFSpeechRecognizerAuthorizationStatus)
    func startedRecording()
    func stoppedRecording()
}

class SpeechToTextEngineMac{
    // create stt variables
    var recognizer: SFSpeechRecognizer!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest!
    var recognitionTask: SFSpeechRecognitionTask!
    let audioEngine = AVAudioEngine()
    var started = false
    private var instanceNumber: Int
    private var previousResult: SFSpeechRecognitionResult?
    private var myInputNode: AVAudioInputNode?
    private var seenSegments: [Int] = []
    
    weak var delegate: SpeechToTextDelegate?
    
    init(instanceNumber sttInstanceNumber: Int) {
        instanceNumber = sttInstanceNumber
    }
    
    // define stt functions
    func setup(_ delegate_:SpeechToTextDelegate){
//        self.controllerInstance = controller
        self.delegate = delegate_;
        // get permission to perform speech recognition:
        SFSpeechRecognizer.requestAuthorization { authStatus in

          // The authorization status results in changes to the
          // app’s interface, so process the results on the app’s
          // main queue.
            OperationQueue.main.addOperation { [self] in
                switch authStatus {
                    case .authorized:
                        delegate?.permissionUpdated(authStatus);
                    case .denied:
                        delegate?.permissionUpdated(authStatus);
                    case .restricted:
                        delegate?.permissionUpdated(authStatus);
                    case .notDetermined:
                        delegate?.permissionUpdated(authStatus);
                    @unknown default:
                        fatalError()
                }
            }
        }
        
        // Ensure English (or whatever language) locale object is supported & instantiate speech recognizer object with chosen locale (i.e. language)
        let supportedLocales = SFSpeechRecognizer.supportedLocales()
        
        if supportedLocales.contains(Locale(identifier: "en-US")) {
            self.recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
            
            print("Language: ", self.recognizer.locale)
            print("Is available: ", self.recognizer.isAvailable)
            print("Supports on-device recognition: ", self.recognizer.supportsOnDeviceRecognition)
        }
    }
    
    func start(){
        self.myInputNode = self.startAudio()
        // Create recognition request:
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        self.recognitionRequest.shouldReportPartialResults = true
        // SWAP ORDER HERE: REQUEST <–> STARTAUDIO ???
        self.startRecognitionTask(self.myInputNode!)
        self.started = true
    }
    
    private func startAudio() -> AVAudioInputNode {
        let inputNode = self.audioEngine.inputNode
        print("Found ", inputNode.numberOfOutputs, "output buses on system's default audio input device")
        print("Uses format: ", inputNode.outputFormat(forBus: 0))
        print("Name: ", inputNode.name(forOutputBus: 0) ?? "no name")
        
        // grab single channel pointer, put into new AVAudioPCMBuffer object, then pass to request object
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) -> Void in
            self.recognitionRequest?.append(buffer) // singleChannelBuffer (2ch)
        }
        
        self.audioEngine.prepare()
        do {
            try self.audioEngine.start()
            print("audio started")
            delegate?.startedRecording();
        } catch {
            print("AVAudioEngine error: \(error)")
            
        }
        
        return inputNode
    }
    
    private func startRecognitionTask(_ node: AVAudioInputNode){
        self.recognitionTask = self.recognizer.recognitionTask(with: self.recognitionRequest) { [self] result, error in
            var isFinal = false
            
            if let foundResult = result {
                print(foundResult.bestTranscription.formattedString)
                delegate?.transcriptionUpdated(foundResult.bestTranscription.formattedString);
                self.previousResult = foundResult;
                isFinal = foundResult.isFinal;
            }
            
            if error != nil {
                print("There was an error \(error!.localizedDescription)")
                self.audioEngine.stop()
                node.removeTap(onBus: 0)
                node.reset()
                
                self.recognitionRequest.endAudio()
                self.recognitionRequest = nil
                self.recognitionTask.finish()
                self.recognitionTask = nil
                
                self.seenSegments = []
                delegate?.stoppedRecording();
               
                if(self.started)
                {
                    print("Re-starting recognition...")
                    self.start()
                }
              
               
            }
            
            if isFinal {
                print("FINAL RESULT reached")
                self.audioEngine.stop()
                node.removeTap(onBus: 0)
                node.reset()
                
                self.recognitionRequest.endAudio()
                self.recognitionRequest = nil
                self.recognitionTask.cancel()
                self.recognitionTask = nil
                
                self.seenSegments = []
                delegate?.stoppedRecording();
                if(self.started)
                {
                    print("Re-starting recognition...")
                    self.start()
                }
            }

        }
    }
    public func stop()
    {
        if self.audioEngine.isRunning {
            self.audioEngine.stop()
            self.recognitionRequest.endAudio()
            self.recognitionTask.cancel()
        }
        
        self.started = false;
        
        self.seenSegments = []
    }
}
