//
//  GitHub.User.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import Foundation

extension GitHub {
	struct User {
		let avatarUrl: String
		let followersUrl: String
		let followingUrl: String
		let id: Int
		let login: String
		let organizationsUrl: String?
		let reposUrl: String
		let url: String
	}
}

extension GitHub.User: Codable {
	
}
