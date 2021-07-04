//
//  Person.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 03.07.2021.
//

import Foundation

struct Person {
	var avatarUrl: String = ""
	var followersUrl: String?
	var followingUrl: String?
	var id: Int = 0
	var login: String = ""
	var organizationsUrl: String?
	var reposUrl: String = ""
	var url: String = ""

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		if let avatarUrl = try? container.decode(String.self, forKey: .avatarUrl) {
			self.avatarUrl = avatarUrl
		}
		if let id = try? container.decode(Int.self, forKey: .id) {
			self.id = id
		}
		if let login = try? container.decode(String.self, forKey: .login) {
			self.login = login
		}
		if let reposUrl = try? container.decode(String.self, forKey: .reposUrl) {
			self.reposUrl = reposUrl
		}
		if let url  = try? container.decode(String.self, forKey: .url) {
			self.url = url
		}
		if let followersUrl = try? container.decode(String.self, forKey: .followersUrl) {
			self.followersUrl = followersUrl
		}
		if let followingUrl = try? container.decode(String.self, forKey: .followingUrl) {
			self.followingUrl = followingUrl
		}
		if let organizationsUrl = try? container.decode(String.self, forKey: .organizationsUrl) {
			self.organizationsUrl = organizationsUrl
		}
	}
}

extension Person: Codable {
}

struct GitResponse: Codable {
	var totalCount: Int?
	var items: [Person]
	var incompleteResults: Int?

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		totalCount = try container.decode(Int.self, forKey: .totalCount)
		items = try container.decode([Person].self, forKey: .items)
		incompleteResults = nil
	}
}
