//
//  Router.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}
protocol RouterProtocol: RouterMain {
    func initialize()
    func goToRocketLaunchInfoVC(rocketLaunch: RocketLaunch)
    func goToListOfFlickerImagesVC(rocketLaunch: RocketLaunch)
}
final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController? = nil, assemblyBuilder: AssemblyBuilderProtocol? = nil) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func initialize() {
        if let navigationController {
            guard let initialVC = assemblyBuilder?.createListOfRocketLaunchesViewController(router: self) else { return }
            navigationController.viewControllers = [initialVC]
        }
    }
    
    func goToRocketLaunchInfoVC(rocketLaunch: RocketLaunch) {
        if let navigationController {
            guard let rocketLaunchInfoVC = assemblyBuilder?.createRocketLaunchInfoViewController(router: self, rocketLaunch: rocketLaunch) else { return }
            navigationController.viewControllers.append(rocketLaunchInfoVC)
        }
    }
    func goToListOfFlickerImagesVC(rocketLaunch: RocketLaunch) {
        if let navigationController {
            guard let listOfFlickerImagesVC = assemblyBuilder?.createListOfFlickerImagesViewController(router: self, rocketLaunch: rocketLaunch) else { return }
            navigationController.viewControllers.append(listOfFlickerImagesVC)
        }
    }
    
}
