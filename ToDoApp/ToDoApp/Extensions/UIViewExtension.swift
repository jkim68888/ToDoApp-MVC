//
//  UIViewExtension.swift
//  ToDoApp
//
//  Created by 김지현 on 2022/10/14.
//

import UIKit

extension UIView {
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		layer.mask = mask
	}
}

extension UIView {
	func snapshotCellStyle() -> UIView {
		let image = snapshot()
		let cellSnapshot = UIImageView(image: image)
		cellSnapshot.layer.masksToBounds = false
		cellSnapshot.layer.cornerRadius = 0.0
		cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
		cellSnapshot.layer.shadowRadius = 5.0
		cellSnapshot.layer.shadowOpacity = 0.4
		return cellSnapshot
	}
	
	private func snapshot() -> UIImage {
		UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
		layer.render(in: UIGraphicsGetCurrentContext()!)
		let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
		UIGraphicsEndImageContext()
		return image
	}
}
