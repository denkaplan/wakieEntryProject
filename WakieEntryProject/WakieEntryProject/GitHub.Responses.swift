//
//  GitHub.Response.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import Foundation

extension GitHub {
	struct UsersResponse {
		var totalCount: Int
		var items: [GitHub.User]
	}
}


extension GitHub.UsersResponse: Codable {

	init(from decoder: Decoder) throws {
		   let container = try decoder.container(keyedBy: CodingKeys.self)
		   totalCount = try container.decode(Int.self, forKey: .totalCount)
			items = try container.decode([GitHub.User].self, forKey: .items)
	}
}
