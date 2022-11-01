//
//  EditViewController.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

protocol SendUpdatedDataDelegate {
	func sendUpdatedData(todoList: [ToDoData])
}

class EditViewController: UIViewController {
	@IBOutlet weak var editTableView: UITableView!
	@IBOutlet weak var deleteAllButton: UIButton!
	
	let toDoManager = CoreDataManager.shared
	
	var delegate: SendUpdatedDataDelegate?
	
	var todoList: [ToDoData]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setTableView()
		setUI()
		// Drag & Drop 기능을 위한 부분
		editTableView.dragInteractionEnabled = true
		editTableView.dragDelegate = self
		editTableView.dropDelegate = self
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
		deleteAllButton.layer.borderWidth = 1
		deleteAllButton.layer.borderColor = UIColor.systemRed.cgColor
		deleteAllButton.layer.cornerRadius = 5
	}

	@IBAction func completeButtonTapped(_ sender: UIButton) {
		navigationController?.popViewController(animated: true)
		
		// home뷰컨으로 데이터 전달
		guard let todoList = self.todoList else { return }
		delegate?.sendUpdatedData(todoList: todoList)
	}
	
	@IBAction func deleteAllButtonTapped(_ sender: UIButton) {
		toDoManager.deleteAllData()
		todoList = []
		editTableView.reloadData()
	}
}

// MARK: - UITableView UITableViewDelegate & UITableViewDataSource
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
	
	// 삭제
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .normal, title: "삭제") { (action, view, completion) in
			// 데이터 삭제
			let newToDoList = self.toDoManager.deleteToDoData(index: indexPath.row)
			self.todoList = newToDoList
			
			// cell 삭제
			tableView.deleteRows(at: [indexPath], with: .automatic)
			
			completion(true)
		}
		
		action.backgroundColor = .systemRed
		
		let configuration = UISwipeActionsConfiguration(actions: [action])

		return configuration
	}
	
	// 이동
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
		
		guard var todoList = self.todoList else { return }
		
		let moveCell = todoList[sourceIndexPath.row]
		
		todoList.remove(at: sourceIndexPath.row)
		todoList.insert(moveCell, at: destinationIndexPath.row)
		
		// orderId 변경
		todoList[destinationIndexPath.row].orderId = Int64(destinationIndexPath.row)
		
		todoList.enumerated().forEach { $1.orderId = Int64($0) }
		
		// 데이터 업데이트
		self.toDoManager.updateToDoList(newToDoList: todoList)
		
		// 뷰컨 todoList에 바뀐 데이터 넣기
		self.todoList = todoList
	}
	
	// 테이블뷰의 높이를 자동적으로 추청하도록 하는 메서드
	// (ToDo에서 메세지가 길때는 셀의 높이를 더 높게 ==> 셀의 오토레이아웃 설정도 필요)
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

// MARK: - UITableView UITableViewDragDelegate
extension EditViewController: UITableViewDragDelegate {
	func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		return [UIDragItem(itemProvider: NSItemProvider())]
	}
}

// MARK: - UITableView UITableViewDropDelegate
extension EditViewController: UITableViewDropDelegate {
	
	func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
		
		if session.localDragSession != nil {
			return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
		}
		
		return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
	}
	
	func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
}

