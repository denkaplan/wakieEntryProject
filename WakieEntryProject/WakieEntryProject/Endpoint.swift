//
//  Network.Endpoint.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import Foundation

extension Network {
	enum HttpMethod: String {
		case GET
	}
}

protocol EndpointProtocol {
	var scheme: String { get }
	var host: String { get }
	var path: String { get }
	var query: [URLQueryItem] { get }
	var body: [String: AnyHashable] { get }
	var headers: [String: AnyHashable] { get }
	var method: Network.HttpMethod { get }
}

extension EndpointProtocol {

}
