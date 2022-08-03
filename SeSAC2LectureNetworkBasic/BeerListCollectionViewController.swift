//
//  BeerListCollectionViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerListCollectionViewController: UICollectionViewController {

    struct BeerData {
        let beerName: String
        let beerDescription: String
        let beerImage_url: String
    }
    
    var beerInfo: [BeerData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // design cell layout
        let cellLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let screenWidth = UIScreen.main.bounds.width - (spacing * 2)
        cellLayout.itemSize = CGSize(width: screenWidth , height: screenWidth * 0.5 )
        cellLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        cellLayout.minimumLineSpacing = spacing
        cellLayout.minimumInteritemSpacing = spacing

        collectionView.collectionViewLayout = cellLayout
    
        getBeerInfo()
    
    
    }

    func getBeerInfo() {
        let url = "https://api.punkapi.com/v2/beers"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let allBeer = json.arrayValue
                
                for beer in allBeer {
                    let name = beer["name"].stringValue
                    let description = beer["description"].stringValue
                    let imageURL = beer["image_url"].stringValue

                    self.beerInfo.append(BeerData(beerName: name, beerDescription: description, beerImage_url: imageURL))
                }
                self.collectionView.reloadData()

                                
            case .failure(let error):
                print(error)
            }
        }
                

    }
    
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerInfo.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerListCollectionViewCell.reuseIdentifier, for: indexPath) as! BeerListCollectionViewCell
        
        cell.backgroundColor = .orange
        cell.beerTitleLabel.text = beerInfo[indexPath.row].beerName
        cell.beerDescriptionLabel.text = beerInfo[indexPath.row].beerDescription
        let beerImageURL = URL(string: beerInfo[indexPath.row].beerImage_url)
        cell.beerImageView.kf.setImage(with: beerImageURL)

        
        return cell
    }
    

}
