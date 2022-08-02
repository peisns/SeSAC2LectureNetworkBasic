//
//  BeerViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/08/02.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        requestBeer()
        
        
        

    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        requestBeer()
    }
    
    
    
    
    func requestBeer() {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                
                let beerName = json[0]["name"].stringValue
                print(beerName)
                self.nameLabel.text = beerName
                
                let beerDescription = json[0]["description"].stringValue
                self.descriptionLabel.text = beerDescription

                let beerImageURL = URL(string: json[0]["image_url"].stringValue)
                
                self.beerImageView.kf.setImage(with: beerImageURL)
                
                

                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    

    
}
