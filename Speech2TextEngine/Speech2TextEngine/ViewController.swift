//
//  ViewController.swift
//  Speech2TextEngine
//
//  Created by pier on 2/2/23.
//

import Cocoa
import AVFoundation
import Speech
import SwiftOSC

class ViewController: NSViewController {
    var stt:SpeechToTextEngineMac! = nil;
    
    
    
    @IBOutlet var _labelAuth:NSTextField?;
    @IBOutlet var _semaphoreAuth:NSView?;
    
    @IBOutlet var _feedbackMicrophoneOn:NSTextField?;
    @IBOutlet var _singleWordLabel:NSTextField?;
    @IBOutlet var _sentenceLabel:NSTextField?;
    
    @IBOutlet var _buttonStartStopRecording:NSButton?;
    var oscClient:OSCClient? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        stt = SpeechToTextEngineMac(instanceNumber: 0);
        stt.setup(self);
        
        //UI initializations
        _semaphoreAuth?.wantsLayer = true;
        _semaphoreAuth?.layer!.cornerRadius  = 6;
        _feedbackMicrophoneOn?.stringValue = "􁙃";
        
        //OSC
        oscClient = OSCClient(address: "localhost", port: 8080);
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func startStopRecording(_ sender:NSButton)
    {
        //􀊱
        if(!stt.started)
        {
            stt.start();
            sender.title = "Stop";
        }
        else
        {
            stt.stop();
            sender.title = "Start Transcription";
        }
    }
    
    
}

extension ViewController:SpeechToTextDelegate{
    func startedRecording() {
        _feedbackMicrophoneOn?.stringValue = "􀊱";
    }
    
    func stoppedRecording() {
        _feedbackMicrophoneOn?.stringValue = "􀊳";
    }
    
    func transcriptionUpdated(_ newSentence: String) {
        
//        _singleWordLabel?.stringValue =   newSentence.components(separatedBy: _sentenceLabel!.stringValue).first!
//        _sentenceLabel?.stringValue = newSentence;
        var previousSentence = _sentenceLabel?.stringValue;
        var difference = ""
            let newWords = newSentence.split(separator: " ")
        let previousWords = previousSentence!.split(separator: " ")
            for (index, word) in newWords.enumerated() {
              if index >= previousWords.count || previousWords[index] != word {
                difference += "\(word) "
              }
            }
//            previousSentence = newSentence
        _sentenceLabel!.stringValue = newSentence
            print("The difference between the previous sentence and the new sentence is: \(difference)")
        _singleWordLabel?.stringValue = difference;
        var message = OSCMessage(
            OSCAddressPattern("/"),
            difference
        )
        oscClient!.send(message)
    }
    
    func permissionUpdated(_ permissionState: SFSpeechRecognizerAuthorizationStatus) {
        switch permissionState {
            case .authorized:
             
                print("authorized")
            _labelAuth?.stringValue = "Authorized";
            _semaphoreAuth?.layer?.backgroundColor = NSColor.green.cgColor;
            case .denied:

                print("denied")
            _labelAuth?.stringValue = "Denied";
            _semaphoreAuth?.layer?.backgroundColor = NSColor.red.cgColor;
            case .restricted:
                print("restricted")
            _labelAuth?.stringValue = "Restricted";
            _semaphoreAuth?.layer?.backgroundColor = NSColor.orange.cgColor;
            case .notDetermined:
                print("not determined")
            _labelAuth?.stringValue = "Not Determined";
            _semaphoreAuth?.layer?.backgroundColor = NSColor.yellow.cgColor;
            @unknown default:
                fatalError()
        }
    }
    
    
}

