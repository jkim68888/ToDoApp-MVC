//
//  AddViewController.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func updateViewConstraints() {
		self.view.frame.size.height = UIScreen.main.bounds.height - 300
		self.view.frame.origin.y =  300
		self.view.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
		super.updateViewConstraints()
	}


}
