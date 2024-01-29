//
//  ListOfRocketsLaunchesPresenter.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation

class ListOfRocketsLaunchesPresenter: ListOfRocketsLaunchesViewControllerOutputProtocol {
    weak var view: ListOfRocketsLaunchesViewControllerInputProtocol!
    var interactor: ListOfRocketsLaunchesInteractorInputProtocol!
    var router: RouterProtocol?
    required init(view: ListOfRocketsLaunchesViewControllerInputProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
extension ListOfRocketsLaunchesPresenter: ListOfRocketsLaunchesInteractorOutputProtocol {
    func viewDidLoad() {
        interactor?.fetchData()
    }
    func getSelectedRocketLaunch(index: Int) {
        interactor?.getNeededRocketLaunchInfo(index: index)
    }
    func dataFetched(rocketLaunches: [RocketLaunch]) {
        view.reloadCollectionView(rocketLaunches: rocketLaunches)
    }
    func goToRocketLaunchVC(rocketLaunch: RocketLaunch) {
        router?.goToRocketLaunchInfoVC(rocketLaunch: rocketLaunch)
    }
}
