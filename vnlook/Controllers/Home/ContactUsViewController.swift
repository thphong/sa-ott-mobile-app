//
//  ContactUsViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 12/01/2024.
//

import UIKit
import MapKit
import Presentr

final class ContactUsViewController: UIViewController {
    private var mapView: MKMapView!
    private var btnSend: UIButton!
    
    let presenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 0.20)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
        let customType = PresentationType.custom(width: width, height: height, center: center)

        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVerticalFromTop
        customPresenter.dismissTransitionType = .crossDissolve
        customPresenter.roundCorners = false
        customPresenter.backgroundColor = .green
        customPresenter.backgroundOpacity = 0.5
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnSwipeDirection = .top
        return customPresenter
    }()
    
    override func loadView() {
        super.loadView()
        
        mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the initial region and other properties of the map
        let initialLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)
        let regionRadius: CLLocationDistance = 500
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // Add an annotation to the map
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        annotation.title = "San Francisco"
        mapView.addAnnotation(annotation)
        
        let title = "Send Message"
        let attrs = [NSAttributedString.Key.font: UIFont.interBold(20), NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalString = NSMutableAttributedString(string: title, attributes: attrs as [NSAttributedString.Key : Any])
        
        btnSend = UIButton(type: .system)
        btnSend.backgroundColor = UIColor(hexString: "#027368")
        btnSend.setAttributedTitle(normalString, for: .normal)
        btnSend.layer.cornerRadius = 10
        btnSend.translatesAutoresizingMaskIntoConstraints = false
        btnSend.addTarget(self, action: #selector(actionOpen), for: .touchUpInside)
        
        mapView.addSubview(btnSend)
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            btnSend.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 32),
            btnSend.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -32),
            btnSend.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -48),
            btnSend.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "#5DA6A6")
        navigationItem.title = "Contact Us"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }

    @objc func actionOpen() {
        let vc = MessageFormViewController()
        customPresentViewController(presenter, viewController: vc, animated: true)
    }
}

extension ContactUsViewController: MKMapViewDelegate {
    
}
