//
//  AvatarService.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import UIKit

protocol AvatarServiceProtocol {

	func load(url: URL, _ completion: @escaping (UIImage?) -> ())
}

