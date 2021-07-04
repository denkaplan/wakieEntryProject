//
//  ContainerControllerProtocol.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import UIKit

protocol ContainerControllerProtocol: UIViewController {

	var contentController: ContentControllerProtocol { get }

	func setupContentController()
}

extension ContainerControllerProtocol where Self: UIViewController {

	func setupContentController() {
		addChild(contentController)
		view.addSubview(contentController.view)
		contentController.view.frame = view.frame
		contentController.didMove(toParent: self)
	}
}

protocol ContentControllerProtocol: UIViewController {

}
