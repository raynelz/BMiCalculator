//
//  SliderEnum.swift
//  BMiCalculator
//
//  Created by Захар Литвинчук on 15.11.2024.
//

import Foundation

enum SliderEnum: String {
	case height = "Рост"
	case weight = "Вес"
	
	func getSlidersValues() -> SlidersValues {
		switch self {
		case .height:
			return SlidersValues(minimumValue: 0, maximumValue: 2.5, initialValue: 1.5, unitOfMeasurement: "m", tag: 1)
		case .weight:
			return SlidersValues(minimumValue: 0, maximumValue: 150, initialValue: 50, unitOfMeasurement: "kg", tag: 2)
		}
	}
}
