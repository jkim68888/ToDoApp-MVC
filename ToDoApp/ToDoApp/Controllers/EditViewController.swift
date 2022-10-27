//
//  EditViewController.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class EditViewController: UIViewController {
	@IBOutlet weak var editTableView: UITableView!
	@IBOutlet weak var deleteAllButton: UIButton!
	
	let toDoManager = CoreDataManager.shared
	
	var todoList: [ToDoData]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setTableView()
		setUI()
    }
	
	// 화면에 다시 진입할때마다 테이블뷰 리로드
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		editTableView.reloadData()
	}
	
	func setTableView() {
		editTableView.delegate = self
		editTableView.dataSource = self
	}
	
	func setUI() {
		
	}

	@IBAction func completeButtonTapped(_ sender: UIButton) {
		navigationController?.popViewController(animated: true)
	}
}

extension EditViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		guard let todoList = self.todoList else { return 0 }
		
		return todoList.count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell", for: indexPath) as? EditTableViewCell else { return UITableViewCell() }
		
		if let todoList = self.todoList {
			cell.toDoData = todoList[indexPath.row]
		}
		
		cell.selectionStyle = .none
		
		return cell
		
	}
	
}
