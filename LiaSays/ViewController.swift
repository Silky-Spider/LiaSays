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

	var colour = arc4random()
	var level = 0
	
	@IBOutlet weak var levelNumber: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	func updateLevel(_ amount: Int = 1) {
		level += amount
		levelNumber.text = String(level)
	}
	// Button controls
	
	@IBAction func redButton(_ sender: UIButton) {
		print("red")
		updateLevel()
		playSound(redBeep)
	}
	
	@IBAction func greenButton(_ sender: UIButton) {
		print("green")
		updateLevel()
		playSound(greenBeep)
	}
	
	@IBAction func yellowButton(_ sender: UIButton) {
		print("yellow")
		updateLevel()
		playSound(yellowBeep)
	}
	
	@IBAction func blueButton(_ sender: UIButton) {
		print("blue")
		updateLevel()
		playSound(blueBeep)
	}
	
}

