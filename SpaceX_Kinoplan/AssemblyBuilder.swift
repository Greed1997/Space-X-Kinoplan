//
//  AssemblyBuilder.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createListOfRocketLaunchesViewController(router: RouterProtocol) -> UIViewController
    func createRocketLaunchInfoViewController(router: RouterProtocol, rocketLaunch: RocketLaunch) -> UIViewController
    func createListOfFlickerImagesViewController(router: RouterProtocol, rocketLaunch: RocketLaunch) -> UIViewController
}
final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createListOfRocketLaunchesViewController(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let viewController = ListOfRocketsLaunchesViewController()
        let presenter = ListOfRocketsLaunchesPresenter(view: viewController, router: router)
        let interactor = ListOfRocketsLaunchesInteractor(presenter: presenter, networkService: networkService)
        viewController.presenter = presenter
        presenter.interactor = interactor
        return viewController
    }
    
    func createRocketLaunchInfoViewController(router: RouterProtocol, rocketLaunch: RocketLaunch) -> UIViewController {
        let networkSevice = NetworkService()
        let cacheStorage = CacheStorage()
        let viewController = RocketLaunchInfoViewController()
        let presenter = RocketLaunchInfoPresenter(view: viewController, router: router, rocketLaunch: rocketLaunch, cacheStorage: cacheStorage, networkService: networkSevice)
        viewController.presenter = presenter
        return viewController
    }
    
    func createListOfFlickerImagesViewController(router: RouterProtocol, rocketLaunch: RocketLaunch) -> UIViewController {
        let viewController = ListOfFlickerImagesViewController()
        let presenter = ListOfFlickerImagesPresenter(view: viewController, router: router, rocketLaunch: rocketLaunch)
        viewController.presenter = presenter
        return viewController
    }
}

