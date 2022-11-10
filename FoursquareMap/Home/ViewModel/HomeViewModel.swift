//
//  HomeViewModel.swift
//  FoursquareMap
//
//  Created by Uri on 10/11/22.
//

import Foundation

class HomeViewModel {
    private weak var view: HomeView?    // weak so everytime a new HomeView is created deletes the previous one
    private var router: HomeRouter?
    //private var managerConnections = ManagerConnections()   // to instantiate our ManagerConnections swift file
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)    // bind our view with our router
    }
}
