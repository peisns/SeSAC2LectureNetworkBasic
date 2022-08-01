//
//  ReusableViewProtocol.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/08/01.
//

import Foundation
import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var reuseIdentifier: String { // 연산 프로퍼티 get만 사용한다면 get 생략 가능
            return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
