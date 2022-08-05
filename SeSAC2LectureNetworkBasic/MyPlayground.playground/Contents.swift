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
//swift 함수 = 일급 객체 특성을 가지고 있음 ***********
//변수 상수에 함수를 넣을 수 있다
//반환타입으로 함수를 넣을 수 있다
//인자 값을 넣을 수 있다??

/*
 1급 객체의특성
 1. 변수나 상수에 함수를 대입할 수 있음
 2. 함수의 반환 타입으로 함수를 사용할 수 있다
 3. 함수의 인자값으로 함수를 사용할 수 있다
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

// 2. 함수의 반환타입으로 함수를 사용할 수 있다.

func currentAccount() -> String { // () -> String
    return "계좌 있음"
}

func noCurrentAccount() -> String { // () -> String
    return "계좌 없음"
}

// 가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
}

let jack = checkBank(bank: "농협") // 함수 자체만 대입
jack() // 실행한 것
checkBank(bank: "농협")() // 실행한 것
print(jack())

//2-1. calculate

func plus(a: Int, b:Int) -> Int { // (int, int) -> Int
    return a + b
}
func minus(a: Int, b:Int) -> Int {
    return a - b
}
func multiply(a: Int, b:Int) -> Int {
    return a * b
}
func divide(a: Int, b:Int) -> Int {
    return a / b
}

//func calculate(operand: String) -> (Int, Int) -> Int {
//    switch operand {
//    case "+": return plus
//    case "-": return minus
//    case "*": return multiply
//    case "/": return divide
//    default:
//        print(#function)
////        return (Int, Int) -> Int
//    }
//}
//
//calculate(operand: "+") // 함수 실행되고 있는 상태 아님
//let resultCalculate = calculate(operand: "+")
//resultCalculate(3,5)





//3번 특성, 함수의 인자값으로 함수를 사용할 수 있다.
//Function Type () -> ()
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}


func plusNumber() {

}
func minusNumber() {
    
}

// 어떤 함수가 들어가던 상관이 없고, 타입만 잘 맞으면 된다.
// 실질적인 연산이 인자값에 들어가는 함수에 달려 있어, 중개 역할만 담당하고 있어서 브로커라고 부름
func resultNumber(number: Int, odd: () -> (), even: () -> () ) {
    return number.isMultiple(of: 2) ? even() : odd()
}

//매개변수로 함수를 전달한다
resultNumber(number: 9, odd: oddNumber, even: evenNumber)

resultNumber(number: 10, odd: plusNumber, even: minusNumber) // 의도 하지 않은 함수가 들어갈 수 있음. 필요 이상의 함수가 자꾸 생김


// 이름 없는 함수, 익명 함수 = 클로저
resultNumber(number: 10) {
    
} even: {
    
}


/*
 클로저도 역시 1급객체의 특성으로 변수나 상수, 반환타입, 인자값에 사용할 수 있다
 */


// () -> ()
func studyiOS() {
    print("주말에도 공부하기")
}


let studyiOSHarder: () -> () = {
    print("주말에도 공부하기")
}

/*
 클로저는 중괄호 처음부터 끝까지 임 in을 기준으로 앞쪽이 함수의 타입(클로저 헤더),
 본 코드가 클로저 바디 라고 함
 { 클로저 헤더 in 클로저 바디 }
 */
let studyiOSharder2 = { () -> () in
    print("주말에도 공부하기")
}

studyiOSharder2

func getStudyWithMe(study: () -> ()) {
    print("getStudyWithMe")
    study()
}

getStudyWithMe(study: studyiOSharder2)

//코드를 생략하지 않고 클로저 구문을 사용
//함수의 매개변수 내에 클로저가 그대로 들어간 형태 -> 인라인(Inline) 클로저
getStudyWithMe(study: { () -> () in
    print("주말에도 공부하기")
})

//함수 뒤에 클로저가 실행
// -> 트레일링(후행) 클로저
getStudyWithMe() { () -> () in
    print("주말에도 공부하기")
}


//func example(number: Int) -> String {
//    return "\(number)"
//}


func randomNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

//인라인 클로저의 상태
randomNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number)입니다."
})

randomNumber(result: { (number) in
    return "행운의 숫자는 \(number)입니다."
})

// 매개변수가 생략되면 할당되어있는 내부 상수 $0을 사용할 수 있다.
// 매개변수가 많다면 $0, $1, $2...
randomNumber(result: {
    "행운의 숫자는 \($0)입니다."
})

randomNumber() {
    "행운의 숫자는 \($0)입니다."
}

randomNumber {
    "\($0)"
}

//randomNumber { _ in
//    "\($0)"
//}

// 함수형 프로그래밍....... 고차함수 : filter map reduce

func processTime(code: () -> () ) {
    let start = CFAbsoluteTimeGetCurrent()
    code()
    let end = CFAbsoluteTimeGetCurrent() - start
    print(end)
}

// ex. 학생 평점 4.0 이상 찾기
let student = [2.2, 4.5, 3.2, 4.4, 1.8, 3.3, 4.1]
var newStudent: [Double] = []

processTime {
    for student in student {
        if student > 4.0 {
            newStudent.append(student)
        }
    }
    print(newStudent)
}





print(newStudent)

let filterStudent = student.filter { value in
    value >= 4.0
}

//let filterStudent2 = student.filter { $0 >= 4.0 } // 클로저의 축약 사용
//
//print(filterStudent)
processTime {
    let filterStudent2 = student.filter { $0 >= 4.0 } // 클로저의 축약 사용
    print(filterStudent)
}

//map: 기존 요소를 클로저를 통해 원하는 결과값으로 변경


let number = [Int](1...100)

var newNumber: [Int] = []

for number in number {
    newNumber.append(number*3)
}
print(newNumber)

let mapNumber = number.map { $0 * 3 }
print(mapNumber)


let movieList = [
    "괴물" : "봉준호",
    "기생충" : "봉준호",
    "인셉션" : "놀란",
    "옥자" : "봉준호",
    "헤어질 결심": "박찬욱"

]
//특정 감독의 영화만 출력
let movieResult = movieList.filter { $0.value == "봉준호" }
print(movieResult)

//영화 이름 배열로 변환?
let movieResult2 = movieList.filter{ $0.value == "봉준호"}.map { $0.key }
print(movieResult2)

//reduce : 초기값 필요함
let exampleScore: [Double] = [100, 44, 20, 50, 66, 94, 52, 95]
var totalCount: Double = 0

for score in exampleScore {
    totalCount += score
}

print(totalCount / 8)

let totalCountUsingReduce = exampleScore.reduce(0) { $0 + $1 }

print(totalCountUsingReduce / 8)


func drawingGame(item: Int) -> String {
    
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...10))"
    }
    
    let result = luckyNumber(number: item)
    return result
}

drawingGame(item: 10) // 외부함수의 생명주기 끝났음 -> 내부 함수의 생명 주기도 끝났음

// 내부 함수를 반환하는 외부 함수로 만들 수 있다.
func drawingGame2(item: Int) -> () -> String {
    
    func luckyNumber() -> String {
        return "\(item * Int.random(in: 1...10))"
    }
    
    return luckyNumber
}

drawingGame2(item: 10) // 내부 함수는 아직 동작하지 않은 상황

let numberResult = drawingGame2(item: 10) // 내부 함수는 아직 동작하지 않음, 외부 함수 생명주기가 끝났음.
numberResult() // 외부 함수의 생명주기가 끝났는데 내부 함수는 사용이 가능한 상황이 됨

//은닉성()이 있는 내부 함수를 외부함수의 실행 결과로 반환하면서 내부 함수를 외부에서도 접근가능하게 되었음
// 이제 얼마든지 호출이 가능. 이건 생명주기에도 영향을 미침. 외부 함수가 종료되었더라도 내부 함수는 살아있음
//

//같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 됨
//클로저에 의해 내부 함수 주변의 지역변수나 상수도 함께 저장됨 -> 값이 캡쳐되었다고 표현함 -> 캡처리스트 -> weak, strong, unowned
//주변 환경에 포함된 변수나 상수의 타입이 기본 자료형이나 구조체 자료형일때 발생함. 클로저 캡쳐 기본 기능임.









