//
//  ViewController.swift
//  cityFetcher
//
//  Created by Adham Ragab on 1/11/20.
//  Copyright © 2020 pharos. All rights reserved.
//

import UIKit
import MapKit

class CityFetchViewController: UITableViewController , UISearchBarDelegate {
    
 
    
    private var cities: [CityModel] = []
    private var filteredCities : [CityModel] = []
    private var currentPage = 1
    private var shouldShowLoadingCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchJSON(page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let cities):
                 DispatchQueue.main.async {
                self.cities = cities ?? []
                
                self.cities = self.cities.sorted { (city1, city2) -> Bool in
                    return city1.name?.compare(city2.name ?? "") == ComparisonResult.orderedAscending
                }
                    
                    self.filteredCities = self.cities
                        self.shouldShowLoadingCell = self.currentPage < 4000
                    
               
                    self.tableView.reloadData()
                }
                
                
                
            case .failure(_):
                print("Error")
            }
        }
        
//        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CityItemCell")
        tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingSpinnerCell")
        
    }
    
    fileprivate func fetchJSON(page: Int = 1, completion:@escaping (Swift.Result<[CityModel]?, NSError>) -> Void ) {
        let urlString = "http://assignment.pharos-solutions.de/cities.json?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get data from url:", err)
                    completion(.failure(NSError()))
                    return
                }
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let cities = try decoder.decode([CityModel].self, from: data)
                    completion(.success(cities))
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }
    
   
    
    func fetchNextPage(){
        currentPage += 1
        
        fetchJSON(page: currentPage) { [weak self] (result) in
            print("fetchingPage\(self!.currentPage)")
                   guard let self = self else { return }
                   switch result {
                   case .success(let cities):
                        DispatchQueue.main.async {
                            
                            for city in cities! {
                                if !self.cities.contains(city){
                                    self.cities.append(city)
                                }
                            }
                       
                       self.cities = self.cities.sorted { (city1, city2) -> Bool in
                           return city1.name?.compare(city2.name ?? "") == ComparisonResult.orderedAscending
                       }
                           if self.currentPage < 4000{
                               self.shouldShowLoadingCell = true
                           }
                     
                            self.filteredCities = self.cities
                           self.tableView.reloadData()
                       }
                       
                       
                       
                   case .failure(_):
                       print("Error")
                   }
               }
        
        
        
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            shouldShowLoadingCell = true
        }else{
            shouldShowLoadingCell = false
        }
              let searchText = searchText.lowercased()
        let filteredCities = cities.filter {(($0.name?.lowercased().contains(searchText)) ?? false)}
              self.filteredCities = filteredCities.isEmpty ? cities : filteredCities
        print(self.filteredCities)
              tableView.reloadData()
          
         
      }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        let filteredCount = filteredCities.count
        print(filteredCount)
        return shouldShowLoadingCell ? filteredCount + 1 : filteredCount
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoadingIndexPath(indexPath){
            let loadingCell = LoadingCell(style: .default, reuseIdentifier: "LoadingSpinnerCell")
            
            return loadingCell
        }else{
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityItemCell") else { return UITableViewCell() }
            
            cell.textLabel?.text = filteredCities[indexPath.row].name
            cell.detailTextLabel?.text = filteredCities[indexPath.row].country

            
        return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else {return}
        tableView.reloadData()
        fetchNextPage()
    }
    
    private func isLoadingIndexPath(_ indexPath:IndexPath) -> Bool{
        guard shouldShowLoadingCell else {return false}
        return indexPath.row == self.filteredCities.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "GoToCityMap", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MapViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.coords = filteredCities[indexPath.row].coord
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
 
    
    
  


}

