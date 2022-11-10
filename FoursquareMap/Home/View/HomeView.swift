//
//  HomeView.swift
//  FoursquareMap
//
//  Created by Uri on 10/11/22.
//

import UIKit
import MapKit
import SnapKit

class HomeView: UIViewController, MKMapViewDelegate {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .orange
    }
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    
    private var mapView: MKMapView {
        let mapView = MKMapView()
        mapView.isZoomEnabled = true
        return mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
