//
//  RocketLaunchInfoViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit

class RocketLaunchInfoViewController: UIViewController {
    private lazy var missionNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = view.backgroundColor
        label.textColor = .black
        return label
    }()
    private lazy var missionPatchImageView: RocketLauncheImageView = {
        let imageView = RocketLauncheImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = view.backgroundColor
        label.textColor = .black
        return label
    }()
    private lazy var youtubeVideoLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Youtube", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(openYoutubeVideo), for: .touchUpInside)
        return button
    }()
    private lazy var wikipediaLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Wikipedia", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(openWikipediaInfo), for: .touchUpInside)
        return button
    }()
    private lazy var redditLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reddit", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(openRedditInfo), for: .touchUpInside)
        return button
    }()
    private lazy var articleLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Article", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(openArticleInfo), for: .touchUpInside)
        return button
    }()
    private lazy var flickrImagesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to see images", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(goTolistOfFlickerImagesVC), for: .touchUpInside)
        return button
    }()

    var presenter: RocketLaunchInfoPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
        setupStackView()
    }
    @objc
    private func openYoutubeVideo() {
        presenter.goToWatchingYoutubeVideo()
    }
    @objc
    private func openWikipediaInfo() {
        presenter.goToWikipedia()
    }
    @objc
    private func openRedditInfo() {
        presenter.goToReddit()
    }
    @objc
    private func openArticleInfo() {
        presenter.goToArticle()
    }
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc
    private func goTolistOfFlickerImagesVC() {
        presenter.goToFlickrImages()
    }
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = CGFloat(view.frame.height / 20)
        stackView.addArrangedSubview(missionNameLabel)
        stackView.addArrangedSubview(missionPatchImageView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(youtubeVideoLinkButton)
        stackView.addArrangedSubview(wikipediaLinkButton)
        stackView.addArrangedSubview(redditLinkButton)
        stackView.addArrangedSubview(articleLinkButton)
        stackView.addArrangedSubview(flickrImagesButton)
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -20),
            stackView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, constant: -20),
            
            
            missionPatchImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 7),
            missionPatchImageView.widthAnchor.constraint(equalToConstant: view.frame.height / 7),
            
            missionNameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8)
        ])
    }
}

// MARK: - RocketLaunchInfoViewProtocol
extension RocketLaunchInfoViewController: RocketLaunchInfoViewProtocol {
    func viewDidLoadFromPresenter(rocketLaunch: RocketLaunch, missionNameText: String, dateText: String, image: UIImage?) {
        updateButtonAvailability(for: rocketLaunch)
        missionNameLabel.text = missionNameText
        dateLabel.text = dateText
        missionPatchImageView.image = image
    }
    func updateButtonAvailability(for rocketLaunch: RocketLaunch) {
        youtubeVideoLinkButton.isHidden = rocketLaunch.links?.youtubeId == nil
        wikipediaLinkButton.isHidden = rocketLaunch.links?.wikipedia == nil
        redditLinkButton.isHidden = rocketLaunch.links?.redditLaunch == nil
        articleLinkButton.isHidden = rocketLaunch.links?.articleLink == nil
        if rocketLaunch.links?.flickrImages == Optional([]) || rocketLaunch.links?.flickrImages == nil {
            flickrImagesButton.isHidden = true
        } else {
            flickrImagesButton.isHidden = false
        }
        if rocketLaunch.links?.missionPatch == nil || rocketLaunch.links?.missionPatch == "" {
            missionPatchImageView.isHidden = true
        } else {
            missionPatchImageView.isHidden = false
        }
        print(rocketLaunch.links?.missionPatch ?? 1234)
    }
}
