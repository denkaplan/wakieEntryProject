//
//  ListContainerController.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import UIKit

final class ListContainerController: UIViewController {

	var contentController: ContentControllerProtocol = ListContentController()
	private let dataSource: ListDataSourceProtocol

	init(networkService: NetworkServiceProtocol) {
		self.dataSource = ListDataSource(networkService: networkService)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationController?.navigationController.style

		title = "GitHub"
		setupContentController()
		tableViewController?.tableView.dataSource = self
		tableViewController?.tableView.delegate = self

		dataSource.loadNextPage { error in
			if error == nil {
				DispatchQueue.main.async {
					self.tableViewController?.tableView.reloadData()
				}
			}
		}
	}
}

extension ListContainerController: ContainerControllerProtocol {}

private extension ListContainerController {

	var tableViewController: UITableViewController? {
		contentController as? UITableViewController
	}
}

extension ListContainerController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.users.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.identifier) as? PersonCell,
		   let user = dataSource.user(for: indexPath) {
			cell.setModel(user: user)
			return cell
		}
		return UITableViewCell()
	}
}

extension ListContainerController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
