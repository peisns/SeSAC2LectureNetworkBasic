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

    @IBOutlet var lottoNumberCollection: [UILabel]!
    
    
    
    var lottoPickerView = UIPickerView()
    
    
    var numberList: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self

        numberTextField.inputView = lottoPickerView
        
        var newNumber = checkDate()
        requestLotto(number: newNumber)
    }
    
    func checkDate() -> Int {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let nowDate = Date()
        let date1026 = "2022-07-23 00:00:00"
        let convertDate1026 = dateformatter.date(from: date1026)!
        let interval = nowDate.timeIntervalSince(convertDate1026)
        let newNumber = 1025 + Int(interval / (86400 * 7))
        numberList.insert(newNumber, at: 0)
        return newNumber
    }
    
    func requestLotto(number: Int) {
        
        //AF: 200~299 status code
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let bonus = json["bnusNo"].intValue
                print(bonus)
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                print("==1==")
                self.numberTextField.text = date
                
                var lottoNumArray: [String] = []
                var lottoNumIndex = 1
                for _ in 1...6 {
                    lottoNumArray.append(String(json["drwtNo\(lottoNumIndex)"].intValue))
                    lottoNumIndex += 1
                }
                print(lottoNumArray)
                
                var lottoLabelIndex = 0
                for num in self.lottoNumberCollection {
                    if lottoLabelIndex < 6 {
                        num.text = lottoNumArray[lottoLabelIndex]
                    } else {
                        num.text = String(bonus)
                    }
                    lottoLabelIndex += 1
                }
                
                
                
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
        print("==2==")
        numberTextField.text = "\(numberList[row])회차"
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
