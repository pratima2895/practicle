//
//  ForcastViewController.swift
//  Practicle
//
//  Created by Pratima on 18/11/23.
//

import UIKit

class ForcastViewController: UIViewController {
    
    @IBOutlet weak var labelTitleSearchFor: UILabel!
    @IBOutlet weak var textFieldCityName: UIAppTextField!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var buttonSearch: UIButton!
    
    @IBOutlet weak var stackCityInfoContainer: UIStackView!
    @IBOutlet weak var labelTitleCityInfo: UILabel!
    @IBOutlet weak var labelTitleCityName: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelTitleRegion: UILabel!
    @IBOutlet weak var labelRegion: UILabel!
    @IBOutlet weak var labelTitleCountry: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelTitleLocalTime: UILabel!
    @IBOutlet weak var labelLocalTime: UILabel!
    
    @IBOutlet weak var stackWeatherInfoContainer: UIStackView!
    @IBOutlet weak var labelTitleWeatherInfo: UILabel!
    @IBOutlet weak var tableViewWeatherInfo: UITableView!
    @IBOutlet weak var heightTableViewWeatherInfo: NSLayoutConstraint!
    
    var viewModel : HomeViewModel!
    var forcastResponseItem : WeatherForecastModel.Response?
    
    var arrayForcast : [WeatherForecastModel.Response.Forecast.ForecastDay] {
        return self.forcastResponseItem?.forecast?.forecastday ?? []
    }
    
    class func instance(viewModel: HomeViewModel, responseItem: WeatherForecastModel.Response) -> ForcastViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewC = (storyboard.instantiateViewController(withIdentifier: "ForcastViewController") as? ForcastViewController) ?? ForcastViewController()
        viewC.viewModel = viewModel
        viewC.forcastResponseItem = responseItem
        return viewC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldCityName.setDoneOnKeyboard()
        
        self.navigationItem.title = "Weather Cast"
        
        self.loadViewData()
        self.initializeTableView()
    }
    
    func loadViewData() {
        self.textFieldCityName.text = self.forcastResponseItem?.searchedCity
        
        self.labelCityName.text = self.forcastResponseItem?.searchedCity
        self.labelRegion.text = self.forcastResponseItem?.location?.region
        self.labelCountry.text = self.forcastResponseItem?.location?.country
        self.labelLocalTime.text = self.forcastResponseItem?.location?.localtime
    }
    
    @IBAction func actionButtonSearch(_ sender: UIButton) {
        self.view.endEditing(true)
        if (self.textFieldCityName.text ?? "").isEmpty {
            self.showMessage("Please enter city name")
        } else {
            //Will Call API for Weather cast
            self.activityLoader.isHidden = false
            self.activityLoader.startAnimating()
            self.buttonSearch.alpha = 0.5
            self.buttonSearch.isUserInteractionEnabled = false
            
            self.viewModel.callAPIForGetWathercastFor(city: self.textFieldCityName.text) { success, response, errorMessage in
                self.activityLoader.isHidden = true
                self.activityLoader.stopAnimating()
                self.buttonSearch.alpha = 1.0
                self.buttonSearch.isUserInteractionEnabled = true
                
                if success == true, let response = response {
                    //Reload all Data
                    self.forcastResponseItem = response
                    self.loadViewData()
                    self.initializeTableView()
                } else {
                    self.showMessage(errorMessage)
                    self.textFieldCityName.text = self.forcastResponseItem?.searchedCity
                }
            }
        }
    }
    
}

extension ForcastViewController : UITableViewDelegate, UITableViewDataSource {
    func initializeTableView() {
        self.tableViewWeatherInfo.register(TVCellDayWeatherInfo.nib, forCellReuseIdentifier: TVCellDayWeatherInfo.identifier)
        
        self.tableViewWeatherInfo.delegate = self
        self.tableViewWeatherInfo.dataSource = self
        
        self.heightTableViewWeatherInfo.constant = UIScreen.main.bounds.size.height * CGFloat(self.arrayForcast.count)
        self.view.layoutIfNeeded()
        
        self.tableViewWeatherInfo.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.heightTableViewWeatherInfo.constant = self.tableViewWeatherInfo.contentSize.height
            self.view.layoutIfNeeded()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayForcast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.arrayForcast[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TVCellDayWeatherInfo.identifier) as! TVCellDayWeatherInfo
        cell.loadModel(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UITextField {
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
