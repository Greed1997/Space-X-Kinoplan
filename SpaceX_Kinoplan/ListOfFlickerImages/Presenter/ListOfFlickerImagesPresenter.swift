//
//  ListOfFlickerImagesPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

protocol ListOfFlickerImagesViewProtocol: AnyObject {
    func reloadCollectionView(flickerImagesUrlString: [String])
    func setTitleVC(title: String)
}
protocol ListOfFlickerImagesPresenterProtocol: AnyObject {
    init(view: ListOfFlickerImagesViewProtocol, router: RouterProtocol, rocketLaunch: RocketLaunch)
    func viewDidLoad()
}
class ListOfFlickerImagesPresenter: ListOfFlickerImagesPresenterProtocol {
    
    let rocketLaunch: RocketLaunch!
    var router: RouterProtocol?
    weak var view: ListOfFlickerImagesViewProtocol?
    func viewDidLoad() {
        guard let missionName = rocketLaunch.missionName else { return }
        guard let flickerImages = rocketLaunch.links?.flickrImages else { return }
        view?.setTitleVC(title: missionName)
        view?.reloadCollectionView(flickerImagesUrlString: flickerImages)
    }

    required init(view: ListOfFlickerImagesViewProtocol, router: RouterProtocol, rocketLaunch: RocketLaunch) {
        self.view = view
        self.router = router
        self.rocketLaunch = rocketLaunch
    }
}
