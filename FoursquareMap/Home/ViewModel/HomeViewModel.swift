//
//  HomeViewModel.swift
//  FoursquareMap
//
//  Created by Uri on 10/11/22.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class HomeViewModel {
    private var router: HomeRouter?
    private var managerConnections = ManagerConnections()   // to instantiate our ManagerConnections swift file
    private var disposeBag = DisposeBag()
    private let venues = BehaviorRelay<[Venue]>(value: [])
    
    func bind(view: HomeView, router: HomeRouter) {
        self.router = router
        self.router?.setSourceView(view)    // bind our view with our router
    }
    
    func getListOfVenues() {
        managerConnections
            .getVenues()
            .subscribe(onSuccess: { [weak self] venues in
                self?.venues.accept(venues)
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    var venueList: Driver<[Venue]> {
        venues.asDriver()
    }
}
