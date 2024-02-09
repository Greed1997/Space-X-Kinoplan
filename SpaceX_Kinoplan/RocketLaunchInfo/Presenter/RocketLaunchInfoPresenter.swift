//
//  RocketLaunchInfoPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import UIKit


struct RocketLaunchInfoModel {
  
}
class RocketLaunchInfoPresenter/*:*/ /*RocketLaunchInfoOutputProtocol*/ {
  
  var rocketLaunch: RocketLaunch?
  var cacheStorage: CacheStorageProtocol?
  var networkService: NetworkServiceProtocol?
  var image: UIImage?
  var router: RocketLaunchInfoRouterProtocol?
  weak var view: RocketLaunchInfoViewProtocol?
  var interactor: RocketLaunchInteractorOutputProtocol?
  
  func viewDidLoad() {
    let missionName = "Mission name: \(String(describing: rocketLaunch?.missionName!))"
    let date = "Date: \(String(describing: rocketLaunch?.launchDateLocal!))"
    guard let urlString = rocketLaunch?.links?.missionPatch else {
      view?.viewDidLoadFromOutput(rocketLaunch: self.rocketLaunch!,
                                  missionNameText: missionName,
                                  dateText: date,
                                  image: nil)
      return
    }
    guard let url = URL(string: urlString) else { return }
    if let cachedImage = cacheStorage!.getCachedImage(from: url) {
      view?.viewDidLoadFromOutput(rocketLaunch: rocketLaunch!, missionNameText: missionName, dateText: date, image: cachedImage)
    } else {
      //            networkService.fetchImage(from: url) { [weak self] data, response in
      //                guard let self = self else { return }
      //                DispatchQueue.main.async { [weak self] in
      //                    guard let self = self else { return }
      //                    if let image = UIImage(data: data) {
      //                        self.image = image
      //                        self.cacheStorage.saveDataToCache(with: data, and: response)
      //                        self.view?.viewDidLoadFromPresenter(rocketLaunch: self.rocketLaunch,
      //                                                            missionNameText: missionName,
      //                                                            dateText: date,
      //                                                            image: self.image)
      //                    }
      //                }
      //            }
    }
  }
  func goToFlickrImages() {
    //router?.goToListOfFlickerImagesVC(rocketLaunch: rocketLaunch!)
  }
  func goToWikipedia() {
    //        if let wikiLink = rocketLaunch.links?.wikipedia {
    //            if let url = URL(string: wikiLink) {
    //                UIApplication.shared.open(url)
    //            }
    //        }
  }
  func goToReddit() {
    //        if let redditLink = rocketLaunch.links?.redditLaunch {
    //            if let url = URL(string: redditLink) {
    //                UIApplication.shared.open(url)
    //            }
    //        }
  }
  func goToArticle() {
    //        if let articleLink = rocketLaunch.links?.articleLink {
    //            if let url = URL(string: articleLink) {
    //                UIApplication.shared.open(url)
    //            }
    //        }
  }
  func goToWatchingYoutubeVideo() {
    //        if let videoID = rocketLaunch.links?.youtubeId {
    //            if let url = URL(string: "youtube://www.youtube.com/watch?v=\(videoID)") {
    //                if UIApplication.shared.canOpenURL(url) {
    //                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
    //                } else {
    //                    if let webURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)") {
    //                        UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
    //                    }
    //                }
    //            }
    //        }
  }
}
