import UIKit
import Foundation

struct ExchangeRate {
    var currencyRate: Double {
        willSet {
            print("Currency rate willSet - 환율 변동 예정: \(currencyRate) ->\(newValue) ")
        }
        didSet {
            print("Currency rate didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
    }
    
    var USD: Double {
        willSet {
            print("USD willSet - 환전 금액 \(newValue)달러로 환전될 예정")
        }
        didSet {
            print("USD didset - 환전 금액 : \(KRW)원 -> \(USD)달러로 환전되었음")
        }
    }
    
    var KRW: Double {
        willSet {
            USD = newValue / currencyRate
            print("KRW willSet - \(newValue)원은 \(USD)달러로 환전될 예정입니다")
        }
        didSet {
            print("KRW didSet - \(KRW)원은 \(USD)달러로 환전되었습니다")
        }
    }
}


// 테스트 예시
var rate = ExchangeRate(currencyRate: 1100, USD: 1, KRW: 100000)
rate.KRW = 5000000
rate.currencyRate = 1350
rate.KRW = 5000000



print("=====")

var date = Date()
print(date)
