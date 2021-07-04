//
//  ListDataSource.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import Foundation

protocol ListDataSourceProtocol {

	var users: [GitHub.User] { get }

	func user(for indexPath: IndexPath) -> GitHub.User?

	func loadNextPage(_ completion: @escaping (Error?) -> ())
}

final class ListDataSource {

	private weak var networkService: NetworkServiceProtocol?

	private var _users = [GitHub.User]()
	private var _page: Int8 = 0

	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}
}

extension ListDataSource: ListDataSourceProtocol {

	var users: [GitHub.User] { _users }

	func user(for indexPath: IndexPath) -> GitHub.User? {
		return _users[indexPath.row]
	}

	func loadNextPage(_ completion: @escaping (Error?) -> ()) {
		_page += 1
		networkService?.perform(for: GitHub.GetUsers(page: _page), GitHub.UsersResponse.self, { result in
			switch result.result {
			case .success(let response):
				self._users.append(contentsOf: response?.items ?? [])
				completion(nil)
				break
			case .failure(let error):
				self._page -= 1
				completion(error)
				break
			}
		})
	}
}
