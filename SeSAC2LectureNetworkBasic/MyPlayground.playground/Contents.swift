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
//var rate = ExchangeRate(currencyRate: 1100, USD: 1, KRW: 100000)
//rate.KRW = 5000000
//rate.currencyRate = 1350
//rate.KRW = 5000000



print("=====")


//일급 객체(first class object), 클로저
//객체는 클래스의 인스턴스
//swift 함수 = 일급 객체 특성을 가지고 있음
//변수 상수에 함수를 넣을 수 있다
//반환타입으로 함수를 넣을 수 있다
//인자 값을 넣을 수 있다??

/*
 1급 객체의특성
 1. 변수나 상수에 함수를 대입할 수 있음
 2. 함수의 인자값으로 함수를 사용할 수 있다
 */

func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "국민", "신한"]
    return bankArray.contains(bank) // ? true : false
}

//변수나 상수에 함수를 실행해서 반환된 반환 값을 대입한 것(1급 객체 특성 아님)
let checkResult = checkBankInformation(bank: "나라")
print(checkResult)

//변수나 상수에 함수 자체를 대입할 수 있다(1급 객체의 특성)
//단지 함수만 대입한 것으로 실행된 상태는 아님
let checkAccount = checkBankInformation

//(String) -> Bool 이게 뭐야? Function Type (ex. Tuple)
let tupleExample = (1, 2, "Hello", true)


//함수를 호출을 해주어야 실행이 된다
print(checkAccount("신한"))


//Function Type: (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)입니다."
}

//Function Type: (String, Int) -> String
func hello(nickname: String, age: Int) -> String {
    return "저는 \(nickname)입니다. \(age)살 입니다."
}

//오버로딩 특성으로 함수를 구분하기 힘들 때, 타입 어노테이션을 통해서 함수를 구별할 수 있다.
//하지만 Function Type이 같을 때, 타입 어노테이션만으로는 함수를 구별할 수 없는 상황도 있다.
//함수 표기법을 사용한다면 타입 어노테이션을 생략하더라도 함수를 구별할 수 있음

let result: (String) -> String = hello(username:)
print(result("고래밥"))
let ageresult: (String, Int) -> String = hello(nickname:age:)
print(ageresult("칙촉", 5))

func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다."
}

let result2 = hello(nickname:)
print(result2("상어밥"))

//2번 특성
//Function Type () -> ()
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func resultNumber(number: Int, odd: () -> (), even: () -> () ) {
    return number.isMultiple(of: 2) ? even() : odd()
}

//매개변수로 함수를 전달한다
resultNumber(number: 9, odd: oddNumber, even: evenNumber)

//익명함수, 클로저
//resultNumber(number: 9) {
//    <#code#>
//} even: {
//    <#code#>
//}

