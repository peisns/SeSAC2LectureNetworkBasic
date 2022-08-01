//
//  LottoViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    var lottoPickerView = UIPickerView()
    
    
    let numberList: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self

        numberTextField.inputView = lottoPickerView
        
        requestLotto(number: 1025)
    }
    
    func requestLotto(number: Int) {
        
        //AF: 200~299 status code
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let bonus = json["bnusNo"].intValue
                print(bonus)
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                self.numberTextField.text = date
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
//        numberTextField.text = "\(numberList[row])회차"
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
