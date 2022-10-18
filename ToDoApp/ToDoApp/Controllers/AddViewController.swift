//
//  AddViewController.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class AddViewController: UIViewController {

	@IBOutlet weak var addTaskTextField: UITextField!
	@IBOutlet weak var highPriorityButton: UIButton!
	@IBOutlet weak var normalPriorityButton: UIButton!
	@IBOutlet weak var lowPriorityButton: UIButton!
	@IBOutlet weak var saveButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		setUI()
    }
	
	override func updateViewConstraints() {
		self.view.frame.size.height = UIScreen.main.bounds.height - 250
		self.view.frame.origin.y =  250
		self.view.roundCorners(corners: [.topLeft, .topRight], radius: 30.0)
		super.updateViewConstraints()
	}
	
	func setPriorityButtonsStyle(buttons: [UIButton]) {
		buttons.forEach {
			$0.backgroundColor = UIColor(hexString: "#ebebeb")
			$0.layer.cornerRadius = 5
			$0.layer.masksToBounds = true
		}
	}
	
	func setUI() {
		highPriorityButton.translatesAutoresizingMaskIntoConstraints = false
		normalPriorityButton.translatesAutoresizingMaskIntoConstraints = false
		lowPriorityButton.translatesAutoresizingMaskIntoConstraints = false
		saveButton.translatesAutoresizingMaskIntoConstraints = false
		
		setPriorityButtonsStyle(buttons: [highPriorityButton, normalPriorityButton, lowPriorityButton])
		
		saveButton.backgroundColor = UIColor(hexString: "#A357D7")
		saveButton.layer.cornerRadius = 5
		saveButton.layer.masksToBounds = true
	}

	@IBAction func closeButtonTapped(_ sender: UIButton) {
		self.dismiss(animated: true)
	}
}
