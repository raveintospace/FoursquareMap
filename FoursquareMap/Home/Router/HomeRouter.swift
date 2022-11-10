//
//  HomeRouter.swift
//  FoursquareMap
//
//  Created by Uri on 10/11/22.
//

import Foundation
import UIKit
import RxSwift

class HomeRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?   // assigns the view used for our HomeRouter
    
    private func createViewController() -> UIViewController {
        let view = HomeView()
        return view
    }
    
    // bind our view with our Router
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {fatalError("Unknown error")}
        
        self.sourceView = view
    }
}
