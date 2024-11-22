//
//  ViewController.swift
//  BMiCalculator
//
//  Created by Захар Литвинчук on 11/1/24.
//

import UIKit

final class ViewController: UIViewController {
	// MARK: - UI Components
	
	let headerView = UIView()
	
	let titleLabel = UILabel()
	let descriptionLabel = UILabel()
	
	// Слайдеры
	let heightSliderView = BMISliderView(sliderType: .height)
	let weightSliderView = BMISliderView(sliderType: .weight)
	
	let calculateButton = UIButton()
	
	let monsterImageView = UIImageView()
	
	private let gradientLayer = CAGradientLayer()
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		embedViews()
		setupLayout()
		setupAppearance()
		setupBehavior()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		gradientLayer.frame = headerView.bounds
	}
}

// MARK: - Private Methods

private extension ViewController {
	
	// MARK: - Embed Views

	func embedViews() {
		view.addSubviews(
			headerView,
			heightSliderView,
			weightSliderView,
			calculateButton,
			monsterImageView
		)
		
		headerView.addSubviews(titleLabel, descriptionLabel)
	}

	// MARK: - Setup Layout
	
	func setupLayout() {
		[
			headerView,
			titleLabel,
			descriptionLabel,
			heightSliderView,
			weightSliderView,
			calculateButton,
			monsterImageView
		].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			headerView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor, constant: 16),
			headerView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor, constant: -16),
			headerView.heightAnchor.constraint(equalToConstant: 200),
			
			titleLabel.topAnchor.constraint(
				equalTo: headerView.topAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(
				equalTo: headerView.leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(
				equalTo: headerView.trailingAnchor, constant: -16),
			
			descriptionLabel.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor, constant: 8),
			descriptionLabel.leadingAnchor.constraint(
				equalTo: titleLabel.leadingAnchor),
			descriptionLabel.trailingAnchor.constraint(
				equalTo: titleLabel.trailingAnchor),
			
			
			heightSliderView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
			heightSliderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			heightSliderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			
			weightSliderView.topAnchor.constraint(equalTo: heightSliderView.bottomAnchor, constant: 30),
			
			weightSliderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			weightSliderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			
			calculateButton.topAnchor.constraint(equalTo: weightSliderView.bottomAnchor, constant: 80),
			calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			monsterImageView.bottomAnchor.constraint(
				equalTo: view.bottomAnchor),
			monsterImageView.leadingAnchor.constraint(
				equalTo: view.leadingAnchor),
			monsterImageView.trailingAnchor.constraint(
				equalTo: view.trailingAnchor),
			monsterImageView.heightAnchor.constraint(equalToConstant: 320),
		])
	}
	
	// MARK: - Setup Appearance
	
	func setupAppearance() {
		view.backgroundColor = .white
		
		gradientLayer.colors = [
			UIColor.brandPurple.cgColor,
			UIColor.brandPink.cgColor,
			UIColor.brandRed.cgColor
		]
		
		gradientLayer.startPoint = .init(x: 0, y: 0.5)
		gradientLayer.endPoint = .init(x: 1, y: 1)
		
		headerView.layer.masksToBounds = true
		headerView.layer.cornerRadius = 20
		headerView.layer.insertSublayer(gradientLayer, at: 0)
		
		titleLabel.text = "Калькулятор ИМТ"
		titleLabel.textColor = .white
		titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
		
		descriptionLabel.text =
		"На данной странице с помощью калькулятора индекса массы тела вы можете рассчитать свой показатель. Достаточно ввести вес и рост в поля ниже."
		descriptionLabel.font = .systemFont(ofSize: 20, weight: .regular)
		descriptionLabel.numberOfLines = 0
		descriptionLabel.textColor = .white
		
		let image = UIImage(systemName: "arrow.right.circle.fill")
		let largeImage = image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
		calculateButton.setImage(largeImage, for: .normal)
		calculateButton.tintColor = .brandPurple
		
		monsterImageView.image = UIImage(named: "monster")
		monsterImageView.contentMode = .scaleAspectFill
	}
	
	// MARK: - Setup Behavior
	
	func setupBehavior() {
		let buttonAction = UIAction { _ in

			var finalHeight = self.heightSliderView.sliderValue
			var finalWeight = self.weightSliderView.sliderValue

			print("Рост: \(finalHeight)")
			print("Вес: \(finalWeight)")

			let bmiValues =  SliderValuesForCalculating(
				height: finalHeight,
				weight: finalWeight
			)
			let nextVc = ResultViewController(bmiValues: bmiValues)
			self.navigationController?.pushViewController(nextVc, animated: true)
		}

		calculateButton.addAction(buttonAction, for: .touchUpInside)
	}
}

#Preview(traits: .portrait) {
	ViewController()
}
