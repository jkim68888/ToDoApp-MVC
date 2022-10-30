//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/20.
//

import UIKit
import CoreData

final class CoreDataManager {
	
	// 싱글톤으로 만들기
	static let shared = CoreDataManager()
	private init() {}
	
	// 앱 델리게이트
	let appDelegate = UIApplication.shared.delegate as? AppDelegate
	
	// 임시저장소
	lazy var context = appDelegate?.persistentContainer.viewContext
	
	// 엔터티 이름 (코어데이터에 저장된 객체)
	let modelName: String = "ToDoData"
	
	// MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
	func getToDoData() -> [ToDoData] {
		var toDoList: [ToDoData] = []
		// 임시저장소 있는지 확인
		if let context = context {
			// 요청서
			let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
			
			let sortDescriptor = [NSSortDescriptor.init(key: "orderId", ascending: true)]
			request.sortDescriptors = sortDescriptor
			
			do {
				// 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
				if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
					toDoList = fetchedToDoList
				}
			} catch {
				print("가져오기 실패")
			}
		}
		
		return toDoList
	}
	
	// MARK: - [Create] 코어데이터에 데이터 생성하기
	func saveToDoData(taskText: String?, priority: Int64, isComplete: Bool, orderId: Int64, completion: @escaping () -> Void) {
		// 임시저장소 있는지 확인
		if let context = context {
			// 임시저장소에 있는 데이터를 그려줄 형태 파악하기
			if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
				
				// 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
				if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
					
					// ToDoData에 실제 데이터 할당 ⭐️
					toDoData.taskText = taskText
					toDoData.priority = priority
					toDoData.isComplete = isComplete
					toDoData.orderId = orderId
					
					UserDefaults.standard.setValue(orderId + 1, forKey: "orderId")
					
					if context.hasChanges {
						do {
							try context.save()
							completion()
						} catch {
							print(error)
							completion()
						}
					}
				}
			}
		}
		completion()
	}
	
	// MARK: - [Update] 코어데이터에서 데이터리스트 업데이트
	func updateToDoList(newToDoList: [ToDoData]) {
		// 임시저장소 있는지 확인
		if let context = context {
			// 요청서
			let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
			
			do {
				// 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
				if var fetchedToDoList = try context.fetch(request) as? [ToDoData] {
					fetchedToDoList = newToDoList
					
					if context.hasChanges {
						do {
							try context.save()
						} catch {
							print(error)
							
						}
					}
				}
			} catch {
				print("삭제 실패")
			}
		}
	}
	
	// MARK: - [Update] 코어데이터에서 데이터 업데이트
	func updateToDoData(newToDoData: ToDoData) {
//		var toDoData: ToDoData
		// 임시저장소 있는지 확인
		if let context = context {
				// 요청서
			let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
			
			do {
				// 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
				if var fetchedToDoList = try context.fetch(request) as? [ToDoData] {
					let index = fetchedToDoList.firstIndex(of: newToDoData)
//					toDoData
					
					if context.hasChanges {
						do {
							try context.save()
						} catch {
							print(error)
							
						}
					}
				}
			} catch {
				print("삭제 실패")
			}
		}
	}
	
	// MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
	func deleteToDoData(index: Int) -> [ToDoData] {
		var toDoList: [ToDoData] = []
		// 임시저장소 있는지 확인
		if let context = context {
			// 요청서
			let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
			
			do {
				// 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
				if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
					toDoList = fetchedToDoList
					// 뷰컨에 보낼 변수 안에 데이터 지움
					toDoList.remove(at: index)
					// 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
					// db에서 지움
					context.delete(fetchedToDoList[index])
					
					//appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
					if context.hasChanges {
						do {
							try context.save()
						} catch {
							print(error)
						}
					}
				}
			} catch {
				print("삭제 실패")
			}
		}
		return toDoList
	}
	
	// MARK: - [DeleteAll] 코어데이터에서 데이터 모두 삭제하기
	func deleteAllData() {
		let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
		request.returnsObjectsAsFaults = false
		
		if let context = context {
			do {
				let results = try context.fetch(request)
				
				for object in results {
					context.delete(object)
				}
				
				if context.hasChanges {
					do {
						try context.save()
					} catch {
						print(error)
					}
				}
			} catch let error {
				print("Detele all data error :", error)
			}
		}
	}
}

