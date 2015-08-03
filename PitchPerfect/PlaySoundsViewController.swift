//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Jon Maldia on 7/12/15.
//  Copyright (c) 2015 Jon Maldia. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
//            var filePathUrl = NSURL.fileURLWithPath(filePath)
//            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
//            audioPlayer.enableRate = true
//        } else {
//            println("The filePath is empty.")
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowButton(sender: AnyObject) {
        PlayTheAudio(0.5)
        /*
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        */
    }

    @IBAction func playFastButton(sender: AnyObject) {
        PlayTheAudio(2.0)
        /*
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        */
    }
    
    func PlayTheAudio(speedOfAudio: Float){
        audioPlayer.stop()
        audioPlayer.rate = speedOfAudio
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        // Task 2 - Fix overlap bug
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopAllAudio(sender: AnyObject) {
        audioPlayer.stop()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
