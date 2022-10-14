//
//  EditViewController.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class EditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func completeButtonTapped(_ sender: UIButton) {
		navigationController?.popViewController(animated: true)
	}
}
