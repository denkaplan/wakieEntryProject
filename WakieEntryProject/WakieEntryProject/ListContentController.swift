//
//  ListContentController.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import UIKit

final class ListContentController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.identifier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44
		tableView.delegate = self
		tableView.sectionFooterHeight = 44
	}
}

extension ListContentController: ContentControllerProtocol {}
