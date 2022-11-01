//
//  EditTableViewCell.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/26.
//

import UIKit

class EditTableViewCell: UITableViewCell {
	@IBOutlet weak var taskLabel: UILabel!
	@IBOutlet weak var taskPriorityImageView: UIImageView!
	@IBOutlet weak var dragImageView: UIImageView!
	
	let toDoManager = CoreDataManager.shared
	
	// ToDoData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행) 
	var toDoData: ToDoData? {
		didSet {
			setData()
		}
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
		
		guard let todoData = toDoData else { return }
//		toDoManager.updateToDoData(newToDoData: todoData)
		print("편집뷰컨", todoData.isComplete)
		
		if todoData.isComplete {
			taskLabel.attributedText = taskLabel.text?.strikeThrough()
		} else {
			taskLabel.attributedText = taskLabel.text?.removeStrikeThrough()
		}
	}

}
