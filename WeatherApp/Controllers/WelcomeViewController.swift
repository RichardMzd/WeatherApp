//
//  WelcomeViewController.swift
//  WeatherApp
//
//  Created by Richard Arif Mazid on 11/03/2023.
//

import Foundation
import UIKit
import Lottie

@available(iOS 15.0, *)
class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var imageView: LottieAnimationView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var loadingMessages = ["Nous téléchargeons les données ...", "C'est presque fini ...", "Plus que quelques secondes ..."]
    var cities = ["Paris", "Rennes", "Nantes", "Bordeaux", "Lyon"]
           
    var weatherArray: [MainWeather]?
    var loadProgressTimer: Timer?
    var msgChangesTimer: Timer?
    var fetchAPITimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetInitialView()
        progressBar.progress = 0.0
        setupButton(button: searchBtn, color: .systemCyan, width: 3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetInitialView()
    }
    
    @IBAction func searchCities(_ sender: UIButton) {
        setAnimation(lottie: imageView, name: "cycle_enjoy")
        self.welcomeLbl.text = self.loadingMessages[0]
        updateLoading()
        self.searchBtn.isHidden = true
    }
    
    func updateLoading() {
        updateLabelMsg()
        updateProgressBar()
    }
    
    // Mehtod which handle the load of progress view whithin 60 seconds
    func updateLabelMsg() {
        var index = 1
        msgChangesTimer = Timer.scheduledTimer(withTimeInterval: 6, repeats: true, block: { (timer) in
            self.welcomeLbl.text = self.loadingMessages[index]
            index += 1
            if index == 3 {
                index = 0
            }
        })
    }
    
    // Mehtod which handle the load of progress view whithin 60 seconds
    func updateProgressBar() {
        var progress: Float = 0.0
        
        progressBar.isHidden = false
        progressBar.progress = progress
        loadProgressTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [self] (timer) in
            progress += 0.02
            self.progressBar.progress = progress
            
            if self.progressBar.progress == 1.0 {
               launchCallAPI()
               self.loadProgressTimer?.invalidate()
            }
        })
    }
    
    func launchCallAPI() {
        fetchAPITimer = Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true, block: { timer in
            self.fetchWeathers()
            self.fetchAPITimer?.invalidate()
        })
    }
    
    // Method which gives city, temperature and weather conditions informations based on the API request which is executed once at the time.
    func fetchWeathers() {
        var index = 0
        var weatherArray = [MainWeather]()
        
        func fetchNextWeather() {
            if index >= cities.count {
                self.performSegue(withIdentifier: "Home_Results", sender: weatherArray)
                return
            }
            
            let city = cities[index]
            WeatherService.shared.getWeather(city: city) { result in
                switch result {
                case .success(let weatherInfo):
                    if let weather = weatherInfo {
                        weatherArray.append(weather)
                    }
                case .failure(let error):
                    self.statusError(status: error , result: result)
                }
                
                index += 1
                fetchNextWeather()
            }
        }
        fetchNextWeather()
    }
    // Method which handle API error message alerts
    func statusError(status: ErrorAPI, result: Result<MainWeather?, ErrorAPI>) {
        switch result {
        case .success(let weather):
            if weather != nil {
                // Handle success case
            }
        case .failure(let error):
            self.alertServerAccess(error: error.description)
        }
    }
}


