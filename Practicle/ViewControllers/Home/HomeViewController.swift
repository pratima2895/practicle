//
//  ViewController.swift
//  Practicle
//
//  Created by Pratima on 16/11/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelScreenTitle: UILabel!
    
    @IBOutlet weak var viewTextFieldContainer: UIView!
    @IBOutlet weak var labelTextFieldTitle: UILabel!
    @IBOutlet weak var textFieldCityName: UIAppTextField!
    
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    let viewModel : HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldCityName.setDoneOnKeyboard()
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
                    //Redirect to the Next Screen
                    let viewC = ForcastViewController.instance(viewModel: self.viewModel, responseItem: response)
                    self.navigationController?.pushViewController(viewC, animated: true)
                } else {
                    self.showMessage(errorMessage)
                }
            }

        }
    }
}

