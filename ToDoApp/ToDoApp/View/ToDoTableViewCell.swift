//
//  CustomTableViewCell.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
	@IBOutlet weak var checkImageView: UIImageView!
	@IBOutlet weak var taskLabel: UILabel!
	@IBOutlet weak var taskPriorityImageView: UIImageView!
	
	let toDoManager = CoreDataManager.shared
	
	// ToDoData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행) ⭐️
	var toDoData: ToDoData? {
		didSet {
			setData()
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		setUI()
    }
	
	func setUI() {
		
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
