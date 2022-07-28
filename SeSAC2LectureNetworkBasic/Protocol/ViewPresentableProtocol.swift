//
//  ViewPresentableProtocol.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/07/28.
//

import Foundation
import UIKit

/*
 ~~~ Protocol
 ~~~ Delegate
 */

//프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다
//실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다
//클래스, 구조체, 익스텐션, 열거형  등의 요소에 사용이 가능함
//클래스는 단일 상속만 가능하지만, 프로토콜은 채택 개수에 제한이 없습니다.
//@objc optional -> 선택적 요청(optional Requirement)
//프로토콜 프로퍼티, 프로토콜 메서드

//프로토콜 프로퍼티: 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관하지 않는다!
//명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고 연산 프로퍼티로 사용할 수도 있다.
//무조건 var로 선언해야한다
//get set은 최소요건임, get만 명시했다면 get기능만 최소한으로 구현이 되어있으며 된다
@objc
protocol ViewPresentableProtocol {
    
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}

/*
 ex. 테이블 뷰
 */

@objc protocol SolTableViewDeleagte {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath:IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
