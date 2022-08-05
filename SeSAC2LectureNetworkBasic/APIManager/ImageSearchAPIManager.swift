//
//  ImageSearchAPIManager.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON


//클래스 싱글턴 패턴 vs 구조체 싱글턴 패턴
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() { }
    
    typealias completionHandler = (Int, [String]) -> Void
    
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping completionHandler) {
        
            let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)"
                    
            let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
            
        AF.request(url, method: .get ,headers: header).validate(statusCode: 200..<500).responseData(queue: .global()) { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    let totalCount = json["total"].intValue
                    
    //                for item in json["items"].arrayValue {
    //                    //20개 셀
    //                    //셀에서 URL, UIImage 변환을 할 건지 =>
    //                    //서버통신받는 시점에서 URL, UIImage 변환을 할 건지 => 시간 오래 걸림.
    //                    self.list.append(item["link"].stringValue)
    //                }
                    let list = json["item"].arrayValue.map { $0["link"].stringValue }
                    
                    completionHandler(totalCount, list)
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}
