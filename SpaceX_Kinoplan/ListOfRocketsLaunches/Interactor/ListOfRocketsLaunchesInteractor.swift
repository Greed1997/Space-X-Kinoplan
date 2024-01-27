//
//  ListOfRocketsLaunchesInteractor.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import Foundation
protocol ListOfRocketsLaunchesInteractorInputProtocol: AnyObject {
    init(presenter: ListOfRocketsLaunchesInteractorOutputProtocol, networkService: NetworkServiceProtocol)
    func fetchData()
    func getNeededRocketLaunchInfo(index: Int)
}
protocol ListOfRocketsLaunchesInteractorOutputProtocol: AnyObject {
    func dataFetched(rocketLaunches: [RocketLaunch])
    func goToRocketLaunchVC(rocketLaunch: RocketLaunch)
}
class ListOfRocketsLaunchesInteractor: ListOfRocketsLaunchesInteractorInputProtocol {
    
    let networkService: NetworkServiceProtocol!
    var rocketLaunches: [RocketLaunch]!
    weak var presenter: ListOfRocketsLaunchesInteractorOutputProtocol!
    required init(presenter: ListOfRocketsLaunchesInteractorOutputProtocol, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.presenter = presenter
    }
    
    func fetchData() {
        networkService.fetchData(from: "https://api.spacexdata.com/v3/launches") { result in
            switch result {
            case .success(let rocketLaunches):
                self.presenter.dataFetched(rocketLaunches: rocketLaunches)
                self.rocketLaunches = rocketLaunches
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNeededRocketLaunchInfo(index: Int) {
        let rocketLaunch = rocketLaunches[index]
        presenter.goToRocketLaunchVC(rocketLaunch: rocketLaunch)
    }
    
}
