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

	let maxSequence = 100
	var level = 2
	var sequence = [Int]()
	var numberOfColours = 0
	var count = 0
	
	@IBOutlet weak var levelNumberLabel: UILabel!
	@IBOutlet weak var countLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		numberOfColours = level * 2
		levelNumberLabel.text = String(level)
		createSequence(lengthOf: maxSequence)
		print("\(sequence)")
		count = 0
		// Do any additional setup after loading the view, typically from a nib.
	}

	func createSequence(lengthOf: Int) {
		for _ in 0..<lengthOf {
			sequence.append(Int(arc4random_uniform(UInt32(numberOfColours))))
		}
	}
	
	func updateCount() {
		count += 1
		countLabel.text = String(count)
	}

	
	// Button controls
	
	@IBAction func redButton(_ sender: UIButton) {
		print("red")
		updateCount()
		playSound(redBeep)
	}
	
	@IBAction func greenButton(_ sender: UIButton) {
		print("green")
		updateCount()
		playSound(greenBeep)
	}
	
	@IBAction func yellowButton(_ sender: UIButton) {
		print("yellow")
		updateCount()
		playSound(yellowBeep)
	}
	
	@IBAction func blueButton(_ sender: UIButton) {
		print("blue")
		updateCount()
		playSound(blueBeep)
	}
	
}

