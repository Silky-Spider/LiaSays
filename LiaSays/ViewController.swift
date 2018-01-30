//
//  ViewController.swift
//  LiaSays
// 	-- A Simon Says lookalike
//
//  Created by Carlos on 2017-12-01.
//  Copyright © 2017 Carlos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	enum Colour : Int {
		case red = 0, green, blue, yellow
	}
	
	let red = UIColor.red
	let blue = UIColor.blue
	let green = UIColor.green
	let yellow = UIColor.yellow
	
	let maxSequence = 99 // they get to maxSequence (+1) they WIN!
	var level = 2					// how hard is the sequence (corresponds to number of colours*2)
	var sequence = [Colour]()	// the random sequence of colours
	var numberOfColours = 0		// level * 2
	var count = 0							// the current number of colours gotten correct
	var maxCount = 0					// the number of colours in current sequence
	var playing = false				// has the game started?
	
	var flashTimer = Timer()
	var nextSequence = 0

	@IBOutlet weak var levelLabel: UILabel! // TEMP -- don't need once more levels added
	@IBOutlet weak var levelNumberLabel: UILabel!
	@IBOutlet weak var countLabel: UILabel!
	@IBOutlet weak var playButton: UIButton!
	@IBOutlet weak var greenButton: UIButton!
	@IBOutlet weak var redButton: UIButton!
	@IBOutlet weak var yellowButton: UIButton!
	@IBOutlet weak var blueButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// TEMP -- only one level (2) for now
		levelLabel.isHidden = true
		levelNumberLabel.isHidden = true
		// TEMP -- only one level (2) for now
	
        numberOfColours = level * 2
		levelNumberLabel.text = String(level)

		}

	func createSequence(lengthOf: Int) {
		sequence = []
		for _ in 0..<lengthOf {
			switch Int(arc4random_uniform(UInt32(numberOfColours))) {
			case 0: sequence.append(.red)
			case 1: sequence.append(.green)
			case 2: sequence.append(.blue)
			default: sequence.append(.yellow)
			}
		}
//		print("\(sequence)")
	}
	
    func updateCount() {
		count += 1
		if count >= maxCount { // give them the next sequence
			count = 0
			maxCount += 1
			showSequence()
		}
        refreshCount()
	}

    func refreshCount() {
        countLabel.text = String(format: "%d/%d", count, maxCount);
    }
	
	func showSequence() {
		print("----- \(maxCount)")
        assert( !flashTimer.isValid, "Timer already underway!" )
		nextSequence = -3 // creates absolute(nextSequence) * .5 second pause
		flashTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self , selector: #selector(flashControl), userInfo: nil, repeats: true)
	}
	
	
	@objc func flashControl() {
		nextSequence += 1
		if nextSequence < 0 { return } // creates a pause before starting first colour
		if nextSequence == maxCount {
			print("got to last sequence")
			flashTimer.invalidate()
			return
		}
//		print(nextSequence)
		print("flashing colour \(self.sequence[nextSequence].rawValue)", terminator: ": " )
		switch sequence[nextSequence] {
		case .red:
			print("red")
			playSound(redBeep)
			flash(button: redButton, colour: red)
		case .blue:
			print("blue")
			playSound(blueBeep)
			flash(button: blueButton, colour: blue)
		case .green:
			print("green")
			playSound(greenBeep)
			flash(button: greenButton, colour: green)
		case .yellow:
			print("yellow")
			playSound(yellowBeep)
			flash(button: yellowButton, colour: yellow)
		}
		
	
	}
	
	
	
	func flash(button: UIButton, colour: UIColor) {
		let duration = 0.2
		UIView.animate(withDuration: duration, animations: {
			button.backgroundColor = UIColor.black
		}) { (true) in
			UIView.animate(withDuration: duration, animations: {
				button.backgroundColor = colour
			})
		}
	}
	
	func gameOver() {
		playSound(bloopBeep)
		playing = false
		playButton.isHidden = false
        countLabel.isHidden = true
	}
	
	// ------ Button controls ------
	
	@IBAction func playButton(_ sender: UIButton) {
		playButton.isHidden = true
        countLabel.isHidden = false
		playing = true
		count = 0
		maxCount = 1

        refreshCount()
        
        createSequence(lengthOf: maxSequence)

//		playSound(startBeep)
		showSequence()
	}

	@IBAction func redButton(_ sender: UIButton) {
        if flashTimer.isValid {
            return
        }
		if !playing {
			playSound(redBeep)
			return
		}
		if sequence[count] == Colour.red {
			updateCount()
			playSound(redBeep)
			flash(button: redButton, colour: red)
		} else {
			gameOver()
		}
	}
	
	@IBAction func greenButton(_ sender: UIButton) {
        if flashTimer.isValid {
            return
        }
		if !playing {
			playSound(greenBeep)
			return
		}
		if sequence[count] == Colour.green {
			updateCount()
			playSound(greenBeep)
			flash(button: greenButton, colour: green )
		} else {
			gameOver()
		}
	}
	
	@IBAction func yellowButton(_ sender: UIButton) {
        if flashTimer.isValid {
            return
        }
		if !playing {
			playSound(yellowBeep)
			return
		}
		if sequence[count] == Colour.yellow {
			updateCount()
			playSound(yellowBeep)
			flash(button: yellowButton, colour: yellow)
		} else {
			gameOver()
		}
	}
	
	@IBAction func blueButton(_ sender: UIButton) {
        if flashTimer.isValid {
            return
        }
        if !playing {
			playSound(blueBeep)
			return
		}
		if sequence[count] == Colour.blue {
			updateCount()
			playSound(blueBeep)
			flash(button: blueButton, colour: blue)
		} else {
			gameOver()
		}
	}
	
}

