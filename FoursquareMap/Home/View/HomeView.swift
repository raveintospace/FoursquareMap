//
//  HomeView.swift
//  FoursquareMap
//
//  Created by Uri on 10/11/22.
//

import UIKit
import MapKit
import SnapKit
import RxSwift

class HomeView: UIViewController, MKMapViewDelegate {
    
    // MARK: - Private vars
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    
    private var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .orange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Venues near HQ"
        setup()
    }
    
    // MARK: - Private funcs
    private func setup() {
        setupView()
        setupConstraints()
        bindRx()
        viewModel.bind(view: self, router: router)
        viewModel.getListOfVenues()
    }
    private func setupView() {
        view.addSubview(mapView)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { (maker) in
            maker.width.equalTo(self.view.snp.width)
            maker.top.equalTo(self.view.safeAreaLayoutGuide)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            maker.centerX.equalTo(self.view.snp.centerX)
        }
    }
    
    private func bindRx() {
        viewModel
            .venueList
            .drive(onNext: { [weak self] venues in
                self?.displayPOIs(venues)
            })
            .disposed(by: disposeBag)
    }
    
    private func displayPOIs(_ venues: [Venue]) {
        let annotations = venues.compactMap { venue -> MKPointAnnotation in
            let poi = MKPointAnnotation()
            poi.title = venue.name
            poi.subtitle = venue.location.formattedAddress.joined(separator: ", ")
            poi.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
            return poi
        }
        mapView.showAnnotations(annotations, animated: true)
    }
}
