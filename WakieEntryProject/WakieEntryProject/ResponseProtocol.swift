//
//  ResponseProtocol.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import Foundation

extension Network {
	struct Response<T: Codable> {
		var response: T?
		var result: Result<T?, Error>
	}
}

extension Network.Response {

	init(error: Error?) {
		self.result = .failure(error ?? NetworkError.some)
	}
}
