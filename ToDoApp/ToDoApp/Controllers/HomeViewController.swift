//
//  ViewController.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

class HomeViewController: UIViewController {
	@IBOutlet weak var homeTableView: UITableView!
	@IBOutlet weak var emtyView: UIImageView!
	@IBOutlet weak var editButton: UIButton!
	@IBOutlet weak var checkImageView: UIImageView!
	
	// 모델(저장 데이터를 관리하는 코어데이터)
	let toDoManager = CoreDataManager.shared
	
	var todoList: [ToDoData]? = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		todoList = toDoManager.getToDoData()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
			self.setTableView()
			self.setUI()
		}
		
		setCheckImageGesture()
	}
	
	// 화면에 다시 진입할때마다 테이블뷰 리로드
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		homeTableView.reloadData()
	}
	
	func setTableView() {
		homeTableView.delegate = self
		homeTableView.dataSource = self
	}

	func setUI() {
		navigationController?.isNavigationBarHidden = true
		
		emtyView.translatesAutoresizingMaskIntoConstraints = false
		emtyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		emtyView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		
		guard let todoList = self.todoList else { return }
		
		if todoList.count == 0 {
			emtyView.isHidden = false
			homeTableView.isHidden = true
			editButton.isHidden = true
		} else {
			emtyView.isHidden = true
			homeTableView.isHidden = false
			editButton.isHidden = false
		}
	}
	
	func setCheckImageGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchToPickPhoto))
		checkImageView.addGestureRecognizer(tapGesture)
//		checkImageView.isUserInteractionEnable(true)
	}
	
	@objc func touchToPickPhoto() {
		//code
		todoList?.forEach{
			$0.isComplete = !$0.isComplete
			
			if $0.isComplete {
				checkImageView.image = UIImage(named: "")
			}
			
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
		if segue.identifier == "toEditView" {
			let viewController = segue.destination as! EditViewController

			viewController.todoList = self.todoList
			viewController.delegate = self
		}
	}
}

// Add뷰컨에서 전달된 데이터 받기
extension HomeViewController: SendAddedDataDelegate {
	func sendAddedData(todoList: [ToDoData]) {
		self.todoList = todoList
		setUI()
		homeTableView.reloadData()
	}
}

// Edit뷰컨에서 전달된 데이터 받기
extension HomeViewController: SendUpdatedDataDelegate {
	func sendUpdatedData(todoList: [ToDoData]) {
		self.todoList = todoList
		setUI()
		homeTableView.reloadData()
	}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		guard let todoList = self.todoList else { return 0 }
		
		return todoList.count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
		
		if let todoList = self.todoList {
			cell.toDoData = todoList[indexPath.row]
		}
	
		cell.selectionStyle = .none
		
		return cell
		
	}
	
}
