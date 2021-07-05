//
//  PersonCell.swift
//  WakieEntryProject
//
//  Created by Deniz Kaplan on 04.07.2021.
//

import UIKit

final class PersonCell: UITableViewCell {
	static let identifier = "PersonCellReusableIdentifier"

	override func prepareForReuse() {
		imageView?.image = nil
	}

	private lazy var avatar: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.cornerRadius = 14
		imageView.layer.masksToBounds = true
		return imageView
	}()

	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var shimmer: ShimmerView = {
		let shimmer = ShimmerView(wrapped: avatar)
		return shimmer
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		translatesAutoresizingMaskIntoConstraints = false
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension PersonCell {

	func setupUI() {
		contentView.addSubview(avatar)
		contentView.addSubview(nameLabel)

		NSLayoutConstraint.activate([
			avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
			avatar.heightAnchor.constraint(equalToConstant: 36),
			avatar.widthAnchor.constraint(equalToConstant: 36),
			avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

			nameLabel.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 24),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
		])

		shimmer.wrap(view: avatar)
	}
}

extension PersonCell {

	func setModel(user: GitHub.User) {
		nameLabel.text = user.login
	}

	func updateAvatar(_ image: UIImage?) {
		DispatchQueue.main.async {
			self.shimmer.isHidden = true
			self.avatar.image = image
		}
	}
}


