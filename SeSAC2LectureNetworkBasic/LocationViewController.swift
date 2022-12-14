//
//  LocationViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by Brother Model on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {
    
//    static var reuseIdentifier: String = String(describing: LocationViewController.self)
    // LocationViewController.self -> 메타타입 -> "LocationViewController"
    
    //Notification 1. 객체 가져오기
    let notificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAuthorization()
    }
    
    @IBAction func downloadImage(_ sender: UIButton) {
        let url = "https://apod.nasa.gov/apod/image/2208/M13_final2_sinfirma.jpg"
        print("1", Thread.isMainThread)
        
        DispatchQueue.global().async {
            print("2", Thread.isMainThread)
            let data = try! Data(contentsOf: URL(string: url)!)
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.imageView.image = image
                print("3", Thread.isMainThread)
            }
        }
        
    }
    
    
    
    
    
    
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        sendNotification()
    }
    
    
    
    
    //Notification 2. 권한 요청
    func requestAuthorization() {
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }

    /*
     - 권한 허용해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한 번 만 뜬다
     - 허용되지 않은 경우, 애플 설정으로 직접 유도하는 코드를 구성해야 한다
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않음
     - 로컬 알림은 60초 이상 반복 가능 / 갯수 제한 64개 / 커스텀 사운드 30초
     
     1. 뱃지 제거 > 언제 제거하는게 맞을까?
     2. 노티 제거 > 노티의 유효 기간은? > 카톡(오픈채팅, 단톡) vs 잔디 > 언제 삭제해주는게 맞을까?
     3. 포그라운드 수신? > 딜리게이트 메서드로 해결!
    
     +a
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     - 포그라운드 수신 > 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 받고 싶다면?
     - iOS15 집중모드 등 5~6 우선순위 존재
     */
    
    //Notification 3. 권한 허용한 사용자에게 알림 요청
    //iOS 시스템에서 알림을 담당 > 알림 등록 코드
    func sendNotification() {
        
        //컨텐츠 구성
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...99))입니다."
        notificationContent.body = "저는 따끔따끔 다마고치 입니다. 배고파요."
        notificationContent.badge = 40
        
        //언제 보낼 것인가?
        //1. 시간 간격(60초 이상 반복 가능)
        //2. 캘린더
        //3. 위치에 따라 설정 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
//        var dateComponents = DateComponents()
//        dateComponents.minute = 11
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //알림 요청
        //identifier: 알림을 관리할 필요가 없다면 X -> 알림 클릭하면 앱을 켜주는 정도
        // 알림을 관리할 필요가 있다면 -> +1, 고유 이름, 규칙, 등
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
}
