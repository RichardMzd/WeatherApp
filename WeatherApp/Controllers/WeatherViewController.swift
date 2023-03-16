//
//  ProgressBarViewController.swift
//  WeatherApp
//
//  Created by Richard Arif Mazid on 11/03/2023.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherTableview: UITableView!
    
    var weatherArray: [MainWeather]?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableview.delegate = self
        weatherTableview.dataSource = self
        setupCell()
        weatherTableview.reloadData()
        displayCurrentDate()
        self.navigationController?.navigationBar.tintColor = .white

    }
    
    func setupCell() {
        let nibName = UINib(nibName: "WeatherViewCell", bundle: nil)
        weatherTableview.register(nibName, forCellReuseIdentifier: "weatherCell")
    }
    
    func displayCurrentDate() {
        let currentDate = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        let dateString = formatter.string(from: currentDate)
        dateLabel?.text = "\(dateString)"
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherArray = weatherArray else { return 0 }
        return weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        guard let weatherArray = weatherArray else { return UITableViewCell() }

        let cityWeather = weatherArray[indexPath.row]
        weatherCell.weatherSet = cityWeather
        return weatherCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return CGFloat(150)
   }
}
