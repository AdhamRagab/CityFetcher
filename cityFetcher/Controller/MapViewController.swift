//
//  MapViewController.swift
//  cityFetcher
//
//  Created by MacBook Pro on 1/12/20.
//  Copyright © 2020 pharos. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var coords: CLLocationCoordinate2D?
       
    let annotation = MKPointAnnotation()

    @IBOutlet var CityMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(coords!)
        
        
        if let coords = coords {
            
            let region = MKCoordinateRegion(center: coords, latitudinalMeters: CLLocationDistance(exactly: 7000)!, longitudinalMeters: CLLocationDistance(exactly: 7000)!)
            CityMap.setRegion(CityMap.regionThatFits(region), animated: true)
            annotation.coordinate = coords
            CityMap.addAnnotation(annotation)
        }
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
