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
	
	let maxSequence = 100 // they get 100 they WIN!
	var level = 2					// how hard is the sequence (corresponds to number of colours*2)
	var sequence = [Colour]()	// the random sequence of colours
	var numberOfColours = 0		// level * 2
	var count = 0							// the current number of colours gotten correct
	var maxCount = 0					// the number of colours in current sequence
	var playing = false				// has the game started?
	
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

		count = 0
		maxCount = 1

		numberOfColours = level * 2
		levelNumberLabel.text = String(level)
		createSequence(lengthOf: maxSequence)

		}

	func createSequence(lengthOf: Int) {
		sequence = []
		for _ in 0..<lengthOf {
			switch Int(arc4random_uniform(UInt32(numberOfColours))) {
			case 0: sequence.append(.green)
			case 1:sequence.append(.red)
			case 2: sequence.append(.yellow)
			default: sequence.append(.blue)
			}
		}
//		print("\(sequence)")
	}
	
	func updateCount() {
		count += 1
		countLabel.text = String(count)
		if count == maxCount { // give them the next sequence
			count = 0
			maxCount += 1
			showSequence()
		}
	}

	
	// Button controls
	@IBAction func playButton(_ sender: UIButton) {
			playButton.isHidden = true
			playing = true
			playSound(startBeep)
			showSequence()
	}
	
	func showSequence() {
		print("----- \(maxCount)")
		for s in 0..<maxCount {
			flash(colour: sequence[s])
			}
	}
	
	func flash(colour: Colour) {
		switch colour {
		case .red: print("red")
		case .green: print("green")
		case .blue: print("blue")
		default: print("yellow")
		}
	}
	
	
	
	@IBAction func redButton(_ sender: UIButton) {
		if !playing {return}
		if sequence[count] == Colour.red {
			updateCount()
			playSound(redBeep)
		} else {
			playSound(bloopBeep)
			playing = false
		}
	}
	
	@IBAction func greenButton(_ sender: UIButton) {
		if !playing {return}
		if sequence[count] == Colour.green {
			updateCount()
			playSound(greenBeep)
		} else {
			playSound(bloopBeep)
			playing = false
		}
	}
	
	@IBAction func yellowButton(_ sender: UIButton) {
		if !playing {return}
		if sequence[count] == Colour.yellow {
			updateCount()
			playSound(yellowBeep)
		} else {
			playSound(bloopBeep)
			playing = false
		}
	}
	
	@IBAction func blueButton(_ sender: UIButton) {
		if !playing {return}
		if sequence[count] == Colour.blue {
			updateCount()
			playSound(blueBeep)
		} else {
			playSound(bloopBeep)
			playing = false
		}
	}
	
}

