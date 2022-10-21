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
	
	let toDoManager = CoreDataManager.shared
	
	var priority: Int64 = 3
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.addTaskTextField.delegate = self
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
		addTaskTextField.translatesAutoresizingMaskIntoConstraints = false
		highPriorityButton.translatesAutoresizingMaskIntoConstraints = false
		normalPriorityButton.translatesAutoresizingMaskIntoConstraints = false
		lowPriorityButton.translatesAutoresizingMaskIntoConstraints = false
		saveButton.translatesAutoresizingMaskIntoConstraints = false
		
		addTaskTextField.backgroundColor = UIColor(hexString: "#ebebeb")
		addTaskTextField.borderStyle = .none
		addTaskTextField.layer.cornerRadius = 5
		addTaskTextField.layer.masksToBounds = true
		
		setPriorityButtonsStyle(buttons: [highPriorityButton, normalPriorityButton, lowPriorityButton])
		
		saveButton.backgroundColor = UIColor(hexString: "#A357D7")
		saveButton.layer.cornerRadius = 5
		saveButton.layer.masksToBounds = true
	}
	
	// 앱의 화면을 터치하면 동작하는 함수 (키보드 이외의 화면 터치시 키보드 내리기)
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	@IBAction func highPriorityButtonTapped(_ sender: UIButton) {
		priority = 0
		
		highPriorityButton.backgroundColor = UIColor(hexString: "#D82525")
		normalPriorityButton.backgroundColor = UIColor(hexString: "#EBEBEB")
		lowPriorityButton.backgroundColor = UIColor(hexString: "#EBEBEB")
		highPriorityButton.setTitleColor(.white, for: .normal)
		normalPriorityButton.setTitleColor(.black, for: .normal)
		lowPriorityButton.setTitleColor(.black, for: .normal)
	}
	
	@IBAction func normalPriorityButtonTapped(_ sender: UIButton) {
		priority = 1
		
		highPriorityButton.backgroundColor = UIColor(hexString: "#EBEBEB")
		normalPriorityButton.backgroundColor = UIColor(hexString: "#FFC700")
		lowPriorityButton.backgroundColor = UIColor(hexString: "#EBEBEB")
		highPriorityButton.setTitleColor(.black, for: .normal)
		normalPriorityButton.setTitleColor(.white, for: .normal)
		lowPriorityButton.setTitleColor(.black, for: .normal)
	}
	
	@IBAction func lowPriorityButtonTapped(_ sender: UIButton) {
		priority = 2
		
		highPriorityButton.backgroundColor = UIColor(hexString: "#EBEBEB")
		normalPriorityButton.backgroundColor = UIColor(hexString: "#EBEBEB")
		lowPriorityButton.backgroundColor = UIColor(hexString: "#249209")
		highPriorityButton.setTitleColor(.black, for: .normal)
		normalPriorityButton.setTitleColor(.black, for: .normal)
		lowPriorityButton.setTitleColor(.white, for: .normal)
	}
	

	@IBAction func closeButtonTapped(_ sender: UIButton) {
		self.dismiss(animated: true)
	}
	
	@IBAction func savButtonTapped(_ sender: UIButton) {
		let todoText = addTaskTextField.text
		let priorityInt = priority
		let success = UIAlertAction(title: "확인", style: .default)
		
		guard let todoText = todoText else { return }
		
		if todoText.isEmpty {
			let todoTextAlert = UIAlertController(title: "할일을 입력해주세요!", message: nil, preferredStyle: .alert)
			
			todoTextAlert.addAction(success)
			present(todoTextAlert, animated: true)
		} else if priorityInt == 3 {
			let priorityAlert = UIAlertController(title: "중요도를 선택해주세요!", message: nil, preferredStyle: .alert)
			
			priorityAlert.addAction(success)
			present(priorityAlert, animated: true)
		} else {
			toDoManager.saveToDoData(taskText: todoText, priority: priorityInt, isComplete: false) {
				print(#function, "저장완료")
				self.dismiss(animated: true)
			}
		}
	}
}

extension AddViewController: UITextFieldDelegate {
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.backgroundColor = .white
		textField.borderStyle = .roundedRect
		
		UIView.animate(withDuration: 0.3) {
			self.view.layoutIfNeeded()
		}
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.backgroundColor = UIColor(hexString: "#ebebeb")
		textField.borderStyle = .none
		
		UIView.animate(withDuration: 0.3) {
			self.view.layoutIfNeeded()
		}
	}
	
	// 리턴키 누를시 키보드 내리기
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}
}
