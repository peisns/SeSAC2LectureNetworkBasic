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

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    
    var imageURL: String = String()
    var list: [String] = []
    var totalCount = 0
    
    //네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        ImageCollectionView.delegate = self
        ImageCollectionView.dataSource = self
        ImageCollectionView.prefetchDataSource = self // 페이지네이션
        
        ImageCollectionView.collectionViewLayout = collectionViewLayout()

    }
    
    // fetch, request, callRequest, getImage ... > response에 따라 네이밍을 설정해주기도 함
    func fetchImage(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
            self.list.append(contentsOf: list)
            DispatchQueue.main.async {
                self.ImageCollectionView.reloadData()
            }
        }
        
//        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//
//        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)"
//
//        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
//
//        AF.request(url, method: .get ,headers: header).validate(statusCode: 200..<500).responseData { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//                let imageURL = json["items"][0]["link"].stringValue
//                self.imageURL = imageURL
//
//                self.totalCount = json["total"].intValue
//
////                for item in json["items"].arrayValue {
////                    //20개 셀
////                    //셀에서 URL, UIImage 변환을 할 건지 =>
////                    //서버통신받는 시점에서 URL, UIImage 변환을 할 건지 => 시간 오래 걸림.
////                    self.list.append(item["link"].stringValue)
////                }
//                let newResult = json["item"].arrayValue.map { $0["link"].stringValue }
//
//                self.list.append(contentsOf: newResult)
//
//                self.ImageCollectionView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            list.removeAll()
            startPage = 1
//            scrollToItem(at: <#T##IndexPath#>, at: <#T##UICollectionView.ScrollPosition#>, animated: <#T##Bool#>)
            fetchImage(query: text)
        }
    }

    //취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        list.removeAll()
        ImageCollectionView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에 커서가 깜빡이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

}




//페이지네이션 방법1. 컬렉션뷰가 특정 셀을 그리려는 시점에 호출되는 메서드
//마지막 셀에 사용자가 위치해있는 지 명확하게 확인하기가 어려움
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }

//페이지네이션 방법2. UIScrollViewDelegateProtocol
//테이블뷰, 컬렉션뷰는 스크롤뷰를 상속받고 있어서 스크롤뷰 프로토콜을 사용할 수 있음
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }

//페이지네이션 방법3. 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적.
//셀이 화면에 보이기 전에 미리 필요한 리소스를 다운 받을 수도 있고, 필요하지 않다면 데이터를 취소할 수도 있음.
//iOS10 이상부터 사용 가능, 스크롤 성능 향상됨
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if list.count - 1 == indexPath.item && list.count < totalCount{
                startPage += 30
                fetchImage(query: searchBar.text!)
            }
        }
        
        
        print("===\(indexPaths)")
    }
    
    // 취소
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소 : \(indexPaths)")
    }
}



extension ImageSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .orange
//        let searchedImageURL = URL(string: imageURL)
        let url = URL(string: list[indexPath.item])
        cell.searchedImageView.kf.setImage(with: url)
        return cell
    }
}

extension ImageSearchViewController {
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
            
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let width = UIScreen.main.bounds.width - (space * 4 + 1)
        layout.itemSize = CGSize(width: width/3, height: width/3)
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        return layout
    }
}
