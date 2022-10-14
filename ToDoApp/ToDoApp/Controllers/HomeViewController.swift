//
//  ViewController.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class HomeViewController: UIViewController {
	@IBOutlet weak var taskTableView: UITableView!
	@IBOutlet weak var emtyView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.isNavigationBarHidden = true
		taskTableView.delegate = self
		taskTableView.dataSource = self
		setUI()
	}

	func setUI() {
		emtyView.translatesAutoresizingMaskIntoConstraints = false
		emtyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		emtyView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	
	@IBAction func editButtonTapped(_ sender: UIButton) {
		performSegue(withIdentifier: "toEditView", sender: self)
		
	}
	
	@IBAction func addButtonTapped(_ sender: UIButton) {
		performSegue(withIdentifier: "toAddView", sender: self)
	}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 5
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
		
		return cell
		
	}
	
}
