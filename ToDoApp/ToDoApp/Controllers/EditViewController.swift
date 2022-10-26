//
//  EditViewController.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class EditViewController: UIViewController {
	@IBOutlet weak var checkImageView: UIImageView!
	@IBOutlet weak var taskLabel: UILabel!
	@IBOutlet weak var taskPriorityImageView: UIImageView!
	@IBOutlet weak var deleteButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func completeButtonTapped(_ sender: UIButton) {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func deleteButtonTapped(_ sender: UIButton) {
		
	}
	
}
