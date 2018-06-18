//
//  ViewController.swift
//  Metronome
//
//  Created by Giovani Nascimento Pereira on 15/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var pulseLabel: UILabel!
    @IBOutlet weak var bgBlue: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var auxView: UIView!
    @IBOutlet weak var compassLabel: UILabel!
    
    let max: Int = 240
    let min: Int = 40
    var timer: Timer = Timer()
    var play: Bool = false
    var compass: Int = 0
    var compassCounter: Int = 0
    
    var pace: Int = 120 {
        didSet {
            pulseLabel.text = "\(pace) BPM"
            progress.progress = Float(pace - min)/Float(max - min)
            if play {
                timer.invalidate()
                self.startMetronome()
            }
        }
    }
    var pulse: Double {
        return 60.0/Double(pace)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgBlue.layer.cornerRadius = bgBlue.frame.width/2
        auxView.layer.cornerRadius = auxView.frame.width/2
        pace = Int(stepper.value)
    }

    @IBAction func stepperValueChanged(_ sender: Any) {
        pace = Int(stepper.value)
    }
    
    func startMetronome() {
        timer = Timer.scheduledTimer(timeInterval: pulse, target: self, selector: #selector(updateMetronome), userInfo: nil, repeats: true)
    }
    
    func stopMetronome() {
        timer.invalidate()
    }
    
    @objc func updateMetronome() {
        pulseView()
        AudioController.playLowBeep()
    }
    
    func pulseView() {
        UIView.transition(with: bgBlue, duration: 0.1, options: .layoutSubviews, animations: {
            self.bgBlue.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { (_) in
            UIView.transition(with: self.bgBlue, duration: 0.1, options: .layoutSubviews, animations: {
                self.bgBlue.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        })
    }
    
    @IBAction func pressStart(_ sender: Any) {
        play = !play
        if play {
            playImage.image = #imageLiteral(resourceName: "PauseOnly")
            self.startMetronome()
        } else {
            playImage.image = #imageLiteral(resourceName: "PlayOnly")
            self.stopMetronome()
        }
    }
}


