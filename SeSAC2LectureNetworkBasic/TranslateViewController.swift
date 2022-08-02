//
//  TranslateViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

//UIControl을 상속 받았는지의 유무에 다라 action 가능할 수도 불가능할 수도 있음
//Responder Chain

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    
    
    
    @IBOutlet weak var translatedTextView: UITextView!
    
    
    let textViewPlaceHolderText = "문장을 작성해주세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceHolderText
        userInputTextView.textColor = .lightGray
        
        userInputTextView.font = UIFont(name:"GangwonEduAll-OTFBold" , size: 17)
        
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        requestTranslateData()
    }
    
    
    
    
    
    func requestTranslateData() {
        
        
        let url = EndPoint.translateURL
        
        let parameter: Parameters = ["source": "ko", "target": "en", "text": userInputTextView.text!]
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .post, parameters: parameter ,headers: header).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    self.translatedTextView.text = json["message"]["result"]["translatedText"].stringValue

                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}

extension TranslateViewController: UITextViewDelegate {
    
    //텍스트의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    //편집이 시작될 때, 커서가 시작될 때
    //테스트뷰 글자 : 플레이스 홀더랑 글자가 같으면 clear
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝났을 때, 커서가 없어지는 순간
    //텍스트뷰 글자: 사용자가 아무 글자도 안썼으면 플레이스 홀더 글자 보이게 해!
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceHolderText
            textView.textColor = .black
        }
    }
}
