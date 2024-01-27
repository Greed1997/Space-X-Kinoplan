//
//  RocketLaunchCell.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit

class RocketLaunchCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseID: String {
        "RocketLaunchCell"
    }
    private lazy var missionNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = backgroundColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private lazy var missionPatchImageView: RocketLauncheImageView = {
        let imageView = RocketLauncheImageView()
        return imageView
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = backgroundColor
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    func configure<U>(with value: U) where U : Hashable {
        guard let value = value as? RocketLaunch else { return }
        missionNameLabel.text = value.missionName!

        let dateString = value.launchDateLocal!
        if let index = value.launchDateLocal?.firstIndex(of: "T") {
            let date = dateString.prefix(upTo: index)
            let time = dateString.suffix(from: dateString.index(after: index))
            let formatedString = "\(date)\n\(time)"
            dateLabel.text = formatedString
        }
        if let missionPatch = value.links?.missionPatch {
            self.missionPatchImageView.fetchImage(from: missionPatch)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setupStackView()
    }
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = CGFloat(5)
        stackView.addArrangedSubview(missionNameLabel)
        stackView.addArrangedSubview(missionPatchImageView)
        stackView.addArrangedSubview(dateLabel)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            missionPatchImageView.heightAnchor.constraint(equalToConstant: frame.width / 2),
            missionPatchImageView.widthAnchor.constraint(equalToConstant: frame.width / 2),
            dateLabel.widthAnchor.constraint(equalToConstant: frame.width - 10),
            missionNameLabel.widthAnchor.constraint(equalToConstant: frame.width - 10)
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
