//
//  UIView+AddSubviews.swift
//  BMiCalculator
//
//  Created by Захар Литвинчук on 11/1/24.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach { addSubview($0) }
	}
}
