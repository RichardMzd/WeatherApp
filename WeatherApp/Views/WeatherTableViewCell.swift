//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Richard Arif Mazid on 14/03/2023.
//

import UIKit
import Lottie

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var conditionLabel: UILabel!
    @IBOutlet private weak var icon: LottieAnimationView!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var weatherSet: MainWeather? {
        didSet {
            cityLabel.text = weatherSet?.name
            tempLabel.text = "\(Int(weatherSet?.main.tempCelsius ?? 0))°C"
            conditionLabel.text = weatherSet?.weather.first?.description.capitalizeFirstLetter ?? "Couvert"
            icon.animation = LottieAnimation.named(weatherSet?.weather.first?.icon ?? "Nopic")
            icon.loopMode = .loop
            icon.contentMode = .scaleAspectFit
            icon.play()
        }
    }
}

