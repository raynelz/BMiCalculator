//
//  BMISliderVIew.swift
//  BMiCalculator
//
//  Created by Захар Литвинчук on 15.11.2024.
//

import UIKit

final class BMISliderView: UIView {
	// MARK: - UI Components
	
	let slider = UISlider()
	
	private let sliderTitleLabel = UILabel()
	private let sliderValueLabel = UILabel()
	
	private let labelStackView = UIStackView()
	
	// MARK: - Properties
	private let sliderType: SliderEnum
	private lazy var slidersValues = sliderType.getSlidersValues()
	private(set) var sliderValue: Float
	
	init(sliderType: SliderEnum) {
		self.sliderType = sliderType
		self.sliderValue = sliderType.getSlidersValues().initialValue
		super.init(frame: .zero)
		
		setupViews()
		setupAppearance()
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension BMISliderView {
	func setupViews() {
		addSubviews(slider, labelStackView)
	}
	
	func setupAppearance() {
		setupSlider()
		setupLabels()
		setupLabelsStackView()
	}
	
	func setupLayout() {
		labelStackView.translatesAutoresizingMaskIntoConstraints = false
		slider.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			labelStackView.topAnchor.constraint(equalTo: topAnchor),
			labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			slider.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 10),
			slider.leadingAnchor.constraint(equalTo: leadingAnchor),
			slider.trailingAnchor.constraint(equalTo: trailingAnchor),
			slider.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	func setupSlider() {
		slider.minimumValue = slidersValues.minimumValue
		slider.maximumValue = slidersValues.maximumValue
		slider.value = slidersValues.initialValue
		slider.minimumTrackTintColor = .brandPurple
		slider.maximumTrackTintColor = .brandPurple.withAlphaComponent(0.2)
		slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
	}
	
	func setupLabels() {
		sliderTitleLabel.text = sliderType.rawValue.capitalized
		sliderValueLabel.text = slidersValues.initialValue.description + slidersValues.unitOfMeasurement
		
		[sliderValueLabel, sliderTitleLabel].forEach {
			$0.font = .systemFont(ofSize: 15, weight: .bold)
			$0.textColor = .black
		}
	}
	
	func setupLabelsStackView() {
		labelStackView.axis = .horizontal
		labelStackView.alignment = .fill
		labelStackView.distribution = .equalSpacing
		[sliderTitleLabel, sliderValueLabel].forEach { labelStackView.addArrangedSubview($0) }
	}
	
	@objc
	func sliderValueChanged(_ sender: UISlider) {
		let value = sender.value
		let roundedValue = round(value * 100) / 100
		sliderValueLabel.text = "\(roundedValue)" + slidersValues.unitOfMeasurement
		sliderValue = roundedValue
	}
}
