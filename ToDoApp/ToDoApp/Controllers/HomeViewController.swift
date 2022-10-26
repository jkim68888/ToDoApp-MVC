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
	
	// 모델(저장 데이터를 관리하는 코어데이터)
	let toDoManager = CoreDataManager.shared
	
	var todoList: [ToDoData]? = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setTableView()
		setUI()
		
		todoList = toDoManager.getToDoData()
	}
	
	// 화면에 다시 진입할때마다 테이블뷰 리로드
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		taskTableView.reloadData()
	}
	
	func setTableView() {
		taskTableView.delegate = self
		taskTableView.dataSource = self
	}

	func setUI() {
		navigationController?.isNavigationBarHidden = true
		
		emtyView.translatesAutoresizingMaskIntoConstraints = false
		emtyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		emtyView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		
		print("홈뷰", #function, toDoManager.getToDoData())
		
		if toDoManager.getToDoData().isEmpty {
			emtyView.isHidden = false
			taskTableView.isHidden = true
		} else {
			emtyView.isHidden = true
			taskTableView.isHidden = false
		}
	}
	
	@IBAction func editButtonTapped(_ sender: UIButton) {
		performSegue(withIdentifier: "toEditView", sender: self)
		
	}
	
	@IBAction func addButtonTapped(_ sender: UIButton) {
		performSegue(withIdentifier: "toAddView", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toAddView" {
			let viewController = segue.destination as! AddViewController
			// protocol delegate 위임
			viewController.delegate = self
		}
	}
}

// Add뷰컨에서 전달된 데이터 받기
extension HomeViewController: SendUpdateDelegate {
	func sendUpdate(todoList: [ToDoData]) {
		self.todoList = todoList
		
		taskTableView.reloadData()
	}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return toDoManager.getToDoData().count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
		
		if let todoList = self.todoList {
			cell.toDoData = todoList[indexPath.row]
		}
	
		cell.selectionStyle = .none
		
		return cell
		
	}
	
}
