//
//  ImageSearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    @IBOutlet weak var ImageCollectionView: UICollectionView!
    
    var imageURL: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageCollectionView.delegate = self
        ImageCollectionView.dataSource = self
        
        // design cell layout
        let cellLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let screenWidth = UIScreen.main.bounds.width - (spacing * 2)
        cellLayout.itemSize = CGSize(width: screenWidth , height: screenWidth)
        cellLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        cellLayout.minimumLineSpacing = spacing
        cellLayout.minimumInteritemSpacing = spacing

        ImageCollectionView.collectionViewLayout = cellLayout

        fetchImage()
    }
    
    // fetch, request, callRequest, getImage ... > response에 따라 네이밍을 설정해주기도 함
    func fetchImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=31"
                
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get ,headers: header).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let imageURL = json["items"][0]["link"].stringValue
                self.imageURL = imageURL
                
                self.ImageCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    

}


extension ImageSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .orange
        let searchedImageURL = URL(string: imageURL)
        cell.searchedImageView.kf.setImage(with: searchedImageURL)
        return cell
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    
}
