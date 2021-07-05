//
//  ShimmerView.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import UIKit

final class ShimmerView: UIView {

	private var wrapped: UIView?

	init(wrapped: UIView) {
		self.wrapped = wrapped
		super.init(frame: .zero)

		alpha = 0.7
		translatesAutoresizingMaskIntoConstraints = false
	}

	func wrap(view: UIView) {
		view.addSubview(self)
		view.layer.masksToBounds = true

		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: view.topAnchor),
			leadingAnchor.constraint(equalTo: view.leadingAnchor),
			trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])

		gradientLayer.colors = [UIColor.darkGray.cgColor, UIColor.lightGray.cgColor]
		gradientLayer.startPoint = CGPoint(x: 0, y: 0)
		gradientLayer.endPoint = CGPoint(x: 1, y: 0)
		animate()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override class var layerClass: AnyClass { CAGradientLayer.self }
}

private extension ShimmerView {

	func animate() {
		let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
		gradientChangeAnimation.duration = 1.0
		gradientChangeAnimation.repeatCount = .infinity
		gradientChangeAnimation.toValue = [UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
		gradientChangeAnimation.fillMode = .both
		gradientChangeAnimation.autoreverses = true
		gradientChangeAnimation.isRemovedOnCompletion = false
		gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
	}

	var gradientLayer: CAGradientLayer {
		layer as? CAGradientLayer ?? CAGradientLayer()
	}
}
