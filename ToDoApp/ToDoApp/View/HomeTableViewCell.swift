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
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
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
}
