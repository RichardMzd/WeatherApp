//
//  Extension.swift
//  WeatherApp
//
//  Created by Richard Arif Mazid on 15/03/2023.
//

import Foundation
import UIKit
import Lottie

extension UIViewController {
    
    //MARK: Alert methods
    //method to detect error in API Call request
    func alertServerAccess(error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

@available(iOS 15.0, *)
extension WelcomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Home_Results" {
            let weatherVC = segue.destination as? WeatherViewController
            let weatherData = sender as? [MainWeather]
            weatherVC?.weatherArray = weatherData
        }
    }
    
    // Method that reset the view from the begining while clicking on back button
    func resetInitialView() {
        setAnimation(lottie: imageView, name: "day_night")
        progressBar.isHidden = true
        searchBtn.isHidden = false
        welcomeLbl.text = "Bienvenue"
        self.msgChangesTimer?.invalidate()
    }
    
    // Method that handle Lottie animation on several UIView
    func setAnimation(lottie: LottieAnimationView, name: String) {
        lottie.animation = LottieAnimation.named(name)
        lottie.loopMode = .loop
        lottie.contentMode = .scaleAspectFill
        lottie.play()
    }
    
    
    func setupButton(button: UIButton, color: UIColor, width: CGFloat) {
        let cgColor: CGColor = color.cgColor
        
        button.layer.borderColor = cgColor
        button.layer.borderWidth = width
        button.layer.cornerRadius = button.bounds.size.height / 2.14
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.backgroundColor = .white
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3.0
    }
}

extension String {
       var capitalizeFirstLetter:String {
            return self.prefix(1).capitalized + dropFirst()
       }
  }

