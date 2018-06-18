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
    @IBOutlet var roundViews: [UIView]!
    @IBOutlet weak var animationSwitch: UISwitch!
    
    @IBOutlet weak var minusView: UIView!
    @IBOutlet weak var plusView: UIView!
    
    // Guides and References
    @IBOutlet weak var settingsGuide1: UIView!
    @IBOutlet weak var settings1: UIView!
    var settings1Center: CGPoint = CGPoint.zero
    var minusCenter: CGPoint = CGPoint.zero
    var plusCenter: CGPoint = CGPoint.zero
    
    let max: Int = 240
    let min: Int = 40
    var timer: Timer = Timer()
    var play: Bool = false
    var compassCounter: Int = 0
    
    var animation: Bool = false
    
    var compass: Int = 0 {
        didSet {
            if compass < 1 {
                compass = 1
            } else if compass > 12 {
                compass = 12
            }
            compassLabel.text = "\(compass)"
        }
    }
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
        for view in roundViews {
            view.layer.cornerRadius = view.frame.width/2
        }
        pace = Int(stepper.value)
        compass = 4
        
        // Get position information
        minusCenter = minusView.center
        plusCenter = plusView.center
        settings1Center = settings1.center
        isHidden = true
        
        // Set settings
        animation = UserDefaultsManager.getAnimationState()
        animationSwitch.isOn = animation
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideButtons()
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
        compassCounter += 1
        
        if compassCounter >= compass {
            if animation {
                pulseView(amount: 0.2)
            }
            AudioController.playHighBeep()
            compassCounter = 0
        } else {
            if animation {
                pulseView(amount: 0.1)
            }
            AudioController.playLowBeep()
        }
    }
    
    func pulseView(amount: CGFloat) {
        UIView.transition(with: bgBlue, duration: 0.1, options: .layoutSubviews, animations: {
            self.bgBlue.transform = CGAffineTransform(scaleX: 1.0 + amount, y: 1.0 + amount)
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
    
    /// Show and hide +/- buttons
    var isHidden: Bool = true
    @IBAction func compassButton(_ sender: Any) {
        isHidden = !isHidden
        
        if isHidden {
            hideButtons()
        } else {
            showButtons()
        }
        UIView.transition(with: auxView, duration: 0.1, options: .curveEaseIn, animations: {
            self.auxView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    @IBAction func compassButtonDown(_ sender: Any) {
        UIView.transition(with: auxView, duration: 0.1, options: .curveEaseIn, animations: {
            self.auxView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
    }
    @IBAction func compassButtonUpOutside(_ sender: Any) {
        UIView.transition(with: auxView, duration: 0.1, options: .curveEaseIn, animations: {
            self.auxView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    @IBAction func minusCompass(_ sender: Any) {
        compass -= 1
    }
    
    @IBAction func plusCompass(_ sender: Any) {
        compass += 1
    }
    
    func showButtons() {
        UIView.transition(with: minusView, duration: 0.5, options: .curveEaseIn, animations: {
            self.minusView.center = self.minusCenter
        }, completion: nil)
        UIView.transition(with: plusView, duration: 0.5, options: .curveEaseIn, animations: {
            self.plusView.center = self.plusCenter
        }, completion: nil)
    }
    
    func hideButtons() {
        UIView.transition(with: minusView, duration: 0.5, options: .curveEaseIn, animations: {
            self.minusView.center = self.auxView.center
        }, completion: nil)
        UIView.transition(with: plusView, duration: 0.5, options: .curveEaseIn, animations: {
            self.plusView.center = self.auxView.center
        }, completion: nil)
    }
    
    var settings: Bool = false
    @IBAction func settingsButton(_ sender: Any) {
        settings = !settings
        if settings {
            showSettings()
        } else {
            hideSettings()
        }
    }
    
    func showSettings() {
        UIView.transition(with: settings1, duration: 0.5, options: .curveEaseIn, animations: {
            self.settings1.center = self.settingsGuide1.center
        }, completion: nil)
    }
    func hideSettings() {
        UIView.transition(with: settings1, duration: 0.5, options: .curveEaseIn, animations: {
            self.settings1.center = self.settings1Center
        }, completion: nil)
    }
    @IBAction func animationSwitchChangedValue(_ sender: Any) {
        self.animation = animationSwitch.isOn
        UserDefaultsManager.setAnimationState(to: animation)
    }
}


