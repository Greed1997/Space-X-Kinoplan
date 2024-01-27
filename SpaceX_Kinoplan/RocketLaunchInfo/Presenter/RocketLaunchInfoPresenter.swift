//
//  RocketLaunchInfoPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import UIKit

protocol RocketLaunchInfoViewProtocol: AnyObject {
    func viewDidLoadPresenter(rocketLaunch: RocketLaunch)
    func updateButtonAvailability(for rocketLaunch: RocketLaunch)
}
protocol RocketLaunchInfoPresenterProtocol: AnyObject {
    init(view: RocketLaunchInfoViewProtocol, router: RouterProtocol, rocketLaunch: RocketLaunch)
    func viewDidLoad()
    func goToWatchingYoutubeVideo()
    func goToWikipedia()
    func goToReddit()
    func goToArticle()
    func goToFlickrImages()
}
class RocketLaunchInfoPresenter: RocketLaunchInfoPresenterProtocol {
    
    let rocketLaunch: RocketLaunch!
    var router: RouterProtocol?
    weak var view: RocketLaunchInfoViewProtocol?
    required init(view: RocketLaunchInfoViewProtocol, router: RouterProtocol, rocketLaunch: RocketLaunch) {
        self.view = view
        self.router = router
        self.rocketLaunch = rocketLaunch
    }
    func viewDidLoad() {
        view?.viewDidLoadPresenter(rocketLaunch: rocketLaunch)
    }
    func goToFlickrImages() {
        router?.goToListOfFlickerImagesVC(rocketLaunch: rocketLaunch)
    }
    func goToWikipedia() {
        if let wikiLink = rocketLaunch.links?.wikipedia {
            if let url = URL(string: wikiLink) {
                UIApplication.shared.open(url)
            }
        }
    }
    func goToReddit() {
        if let redditLink = rocketLaunch.links?.redditLaunch {
            if let url = URL(string: redditLink) {
                UIApplication.shared.open(url)
            }
        }
    }
    func goToArticle() {
        if let articleLink = rocketLaunch.links?.articleLink {
            if let url = URL(string: articleLink) {
                UIApplication.shared.open(url)
            }
        }
    }
    func goToWatchingYoutubeVideo() {
        if let videoID = rocketLaunch.links?.youtubeId {
            if let url = URL(string: "youtube://www.youtube.com/watch?v=\(videoID)") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    if let webURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)") {
                        UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    
}
