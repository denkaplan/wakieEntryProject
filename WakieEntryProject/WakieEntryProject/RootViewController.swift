//
//  RootViewController.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import UIKit

final class RootViewController: UIViewController {

	private let stack: UINavigationController
	private let networkService: NetworkServiceProtocol

	convenience init() {
		self.init(navigationController: UINavigationController(), networkService: NetworkService())
	}

	init(navigationController: UINavigationController,
		 networkService: NetworkServiceProtocol) {
		self.stack = navigationController
		self.networkService = networkService
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		stack.viewControllers = [ListContainerController(networkService: networkService)]

		addChild(stack)
		view.addSubview(stack.view)
		stack.view.frame = view.frame
		stack.didMove(toParent: self)

		networkService.perform(for: GitHub.GetUsers(page: 1), GitHub.UsersResponse.self) { response in
			print(response)
		}
	}
}
