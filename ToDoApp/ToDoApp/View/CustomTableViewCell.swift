//
//  CustomTableViewCell.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
	@IBOutlet weak var checkImageView: UIImageView!
	@IBOutlet weak var taskLabel: UILabel!
	@IBOutlet weak var taskPriorityImageView: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
