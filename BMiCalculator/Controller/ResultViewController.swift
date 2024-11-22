//
//  ResultViewController.swift
//  BMiCalculator
//
//  Created by Захар Литвинчук on 22.11.2024.
//

import UIKit

final class ResultViewController: UIViewController {
	// MARK: - UI Components
	
	private let containerView = UIView()
	
	private let titleLabel = UILabel()
	private let bmiLabel = UILabel()
	private let descriptionLabel = UILabel()
	
	private let navigateBackButton = UIButton()
	
	private let gradientLayer = CAGradientLayer()
	
	// MARK: - Properties
	private let bmiValues: SliderValuesForCalculating
	
	init(bmiValues: SliderValuesForCalculating) {
		self.bmiValues = bmiValues
		super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		embedViews()
		setupAppearance()
		setupLayout()
		setupBehavior()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		gradientLayer.frame = view.bounds
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension ResultViewController {
	func embedViews() {
		view.addSubviews(
			containerView,
			navigateBackButton
		)
		
		containerView.addSubviews(
			titleLabel,
			bmiLabel,
			descriptionLabel
		)
	}

	func setupAppearance() {
		gradientLayer.colors = [
			UIColor.brandPurple.cgColor,
			UIColor.brandPink.cgColor,
			UIColor.brandRed.cgColor
		]

		gradientLayer.startPoint = .init(x: 0, y: 0.5)
		gradientLayer.endPoint = .init(x: 1, y: 1)
		
		view.layer.insertSublayer(gradientLayer, at: 0)
		
		containerView.backgroundColor = .black.withAlphaComponent(0.2)
		containerView.layer.cornerRadius = 20
		
		titleLabel.textColor = .white
		titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
		
		bmiLabel.textColor = .white
		bmiLabel.font = .systemFont(ofSize: 128, weight: .bold)
		bmiLabel.textAlignment = .center
		
		descriptionLabel.textColor = .white
		descriptionLabel.font = .systemFont(ofSize: 18, weight: .regular)
		descriptionLabel.textAlignment = .center
		
		let image = UIImage(systemName: "arrow.left.circle.fill")
		let largeImage = image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
		
		navigateBackButton.setImage(largeImage, for: .normal)
		navigateBackButton.tintColor = .white
	}

	func setupLayout() {
		[
			containerView,
			titleLabel,
			bmiLabel,
			descriptionLabel,
			navigateBackButton
		].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		
		NSLayoutConstraint.activate([
			containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			containerView.heightAnchor.constraint(equalToConstant: (285)),
			containerView.widthAnchor.constraint(equalToConstant: (314)),

			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
			
			bmiLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
			bmiLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
			bmiLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

			descriptionLabel.topAnchor.constraint(equalTo: bmiLabel.bottomAnchor, constant: 12),
			descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
			descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
			
			navigateBackButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 94),
			navigateBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
	
	func setupBehavior() {
		calculateBMI()

		let action = UIAction { _ in
			self.navigationController?.popViewController(animated: true)
		}
		

		titleLabel.text = "Твой результат:"

		navigateBackButton.addAction(action, for: .touchUpInside)
	}
	
	func calculateBMI() {
		let weightValue = bmiValues.weight
		let heightValue = bmiValues.height
		
		guard weightValue != 0, heightValue != 0 else {
			bmiLabel.text = "0"
			descriptionLabel.text = "Введите корректные данные"
			return
		}

		let bmi = weightValue / pow(heightValue, 2)
		let roundedValue = round(bmi * 10) / 10

		bmiLabel.text = "\(roundedValue)"

		switch roundedValue {
		case ..<18.5:
			descriptionLabel.text = "Недостаточный вес"
		case 18.5..<25:
			descriptionLabel.text = "Нормальный вес"
		case 25..<30:
			descriptionLabel.text = "Избыточный вес"
		case 30..<35:
			descriptionLabel.text = "Ожирение I"
		case 35..<40:
			descriptionLabel.text = "Ожирение II"
		case 40...:
			descriptionLabel.text = "Ожирение III"
		default:
			descriptionLabel.text = "Ошибка в расчёте"
		}
	}
}
