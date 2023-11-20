//
//  TVCellDayWeatherInfo.swift
//  Practicle
//
//  Created by Pratima on 18/11/23.
//

import UIKit

class TVCellDayWeatherInfo: UITableViewCell {
    static let identifier = "TVCellDayWeatherInfo"
    static let nib = UINib(nibName: TVCellDayWeatherInfo.identifier, bundle: .main)
    
    @IBOutlet weak var labelCurrentDate: UILabel!

    @IBOutlet weak var imageWeatherIcon: UIImageView!
    @IBOutlet weak var labelTitleTemperature: UILabel!
    
    @IBOutlet weak var viewTemperatureLow: UIView!
    @IBOutlet weak var labelTitleTemperatureLow: UILabel!
    @IBOutlet weak var labelTemperatureLow: UILabel!
    
    @IBOutlet weak var viewTemperatureHigh: UIView!
    @IBOutlet weak var labelTitleTemperatureHigh: UILabel!
    @IBOutlet weak var labelTemperatureHigh: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadModel(_ model: WeatherForecastModel.Response.Forecast.ForecastDay) {
//        self.imageWeatherIcon = ""
        self.labelCurrentDate.text = model.date
        self.labelTemperatureLow.text = String(format: "%0.2fc", model.day?.mintemp_c ?? 0)
        self.labelTemperatureHigh.text = String(format: "%0.2fc", model.day?.maxtemp_c ?? 0)
    }
}
