//
//  NetworkService.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 03.07.2021.
//

import UIKit

typealias ResultClosure<T: Codable> = (Network.Response<T>) -> ()

protocol NetworkServiceProtocol: AnyObject {

	func perform<T: Codable>(for endpoint: EndpointProtocol, _ type: T.Type, _ completion: @escaping ResultClosure<T>)
}

final class NetworkService {

	private let session: URLSession
	private let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()

	convenience init() {
		self.init(session: URLSession.shared)
	}

	init(session: URLSession) {
		self.session = session
	}
}

extension NetworkService: NetworkServiceProtocol {

	func perform<T: Codable>(for endpoint: EndpointProtocol, _ type: T.Type, _ completion: @escaping ResultClosure<T>) {
		guard let request = request(for: endpoint) else {
			completion(Network.Response(error: NetworkError.request))
			return
		}
		session.dataTask(with: request) { [weak self] data, response, error in
			guard let self = self else {
				completion(Network.Response(error: NetworkError.some))
				return
			}
			if let error = error {
				completion(Network.Response(error: error))
				return
			}
			if let response = response, !self.validateHTTP(response: response) {
				completion(Network.Response(error: NetworkError.response))
				return
			}

			guard let data = data else {
				completion(Network.Response(result: .success(nil)))
				return
			}

			do {
				let result = try self.decoder.decode(type, from: data)
				completion(Network.Response(result: .success(result)))
			} catch {
				completion(Network.Response(error: error))
			}
		}.resume()
	}
}

private extension NetworkService {

	func validateHTTP(response: URLResponse) -> Bool {
		guard let httpResponse = response as? HTTPURLResponse else { return false }
		switch httpResponse.statusCode {
		case 200...205:
			return true
		default:
			return false
		}
	}

	func request(for endpoint: EndpointProtocol) -> URLRequest? {
		var components = URLComponents()
		components.host = endpoint.host
		components.scheme = endpoint.scheme
		components.path = endpoint.path
		components.queryItems = endpoint.query
		guard let url = components.url else { return nil }
		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.rawValue
		if endpoint.method != .GET {
			request.httpBody = try? JSONSerialization.data(withJSONObject: endpoint.body, options: .prettyPrinted)
		}
		return request
	}
}

extension NetworkService: AvatarServiceProtocol {

	func load(url: URL, _ completion: @escaping (UIImage?) -> ()) {
		session.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self else {
				completion(nil)
				return
			}
			if let _ = error {
				completion(nil)
				return
			}
			if let response = response, !self.validateHTTP(response: response) {
				completion(nil)
				return
			}
			guard let data = data else {
				completion(nil)
				return
			}
			completion(UIImage(data: data))
		}.resume()
	}
}
