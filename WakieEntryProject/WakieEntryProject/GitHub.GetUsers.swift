//
//  GitHub.GetUsers.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import Foundation

extension GitHub {

	struct GetUsers {
		var page: Int8 = 1
		let host = GitHub.host
		let scheme = GitHub.scheme
		let path = "/search/users"

		var body = [String: AnyHashable]()
		var headers = [String: AnyHashable]()
		var method: Network.HttpMethod = .GET
	}
}

extension GitHub.GetUsers: EndpointProtocol {
	var query: [URLQueryItem] {
		[URLQueryItem(name: "q", value: "all"),
		 URLQueryItem(name: "sort", value: "followers"),
		 URLQueryItem(name: "page", value: String(page))]
	}
}

extension GitHub.GetUsers {
	init(page: Int8) {
		self.page = page
	}
}
