//
//  Constant.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/08/01.
//

import Foundation




//enum StoryboardName: String {
//case Main
//case Search
//case Setting
//}

//struct StoryboardName {
    
    //접근제어를 활용을 위한 초기화 방지
    //private는 해당 파일에서만 사용할 수 있도록 만듦, 다른 파일에서 사용불가
//    private init() {
//    }
//
//    static let main = "Main"
//    static let search = "search"
//    static let setting = "Setting"
//}

/*
 1. struct type property vs enum type property => 인스턴스에 대한 생성 방지
 2. enum case vs enum static => case로는 raw value가 중복 불가능
 */
//
enum StoryboardName {
    static let main = "Main"
    static let search = "search"
    static let setting = "Setting"
}


//enum FontName: String {
//    case title, body = "SanFransico"
//    case caption = "AppleSandol"
//}

//}
