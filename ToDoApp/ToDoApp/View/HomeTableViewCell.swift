//
//  CustomTableViewCell.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
	@IBOutlet weak var checkImageView: UIImageView!
	@IBOutlet weak var taskLabel: UILabel!
	@IBOutlet weak var taskPriorityImageView: UIImageView!
	
	let toDoManager = CoreDataManager.shared
	
	// ToDoData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행)
	var toDoData: ToDoData? {
		didSet {
			setData()
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		setImageGesture()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		taskLabel.attributedText = taskLabel.text?.removeStrikeThrough()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}

	func setData() {
		taskLabel.text = toDoData?.taskText
		
		switch toDoData?.priority {
		case 0 :
			taskPriorityImageView.image = UIImage(named: "high")
		case 1 :
			taskPriorityImageView.image = UIImage(named: "normal")
		case 2 :
			taskPriorityImageView.image = UIImage(named: "low")
		default :
			break
		}
	}
	
	func setImageGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapImage))
		checkImageView.addGestureRecognizer(tapGesture)
		checkImageView.isUserInteractionEnabled = true
	}
	
	@objc func onTapImage() {
		if let todoData = toDoData {
			todoData.isComplete = !todoData.isComplete
			toDoData?.isComplete = todoData.isComplete
			
			toDoManager.updateToDoData(newToDoData: todoData)
			print(todoData.isComplete)
			
			if todoData.isComplete {
				checkImageView.image = UIImage(named: "checked")
				taskLabel.attributedText = taskLabel.text?.strikeThrough()
			} else {
				checkImageView.image = UIImage(named: "unchecked")
				taskLabel.attributedText = taskLabel.text?.removeStrikeThrough()
			}
		}
	}
}
