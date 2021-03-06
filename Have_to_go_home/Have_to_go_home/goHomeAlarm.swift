//
//  goHomeAlarm.swift
//  location
//
//  Created by Christopher on 11/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//
import UIKit
import Foundation
class goHomeAlarm{
    let app = UIApplication.shared
    let notificationSettings = UIUserNotificationSettings()
        //UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil)
    let nsuser = UserDefaults()
    let notifyAlarm = UILocalNotification()
    var first_start_time:NSDate!
    let soundName:String = "bell_tree.mp3"
    // 출발 시간 정해진 거에서 30 분 뺀 시간에 함.
    
    
    init (){
        //세션에서 값 가져오기
        let nsuser = UserDefaults()
        first_start_time = nsuser.object(forKey: "first_start_time") as! NSDate
    }
    func setAlarm(){
        let alertTime = first_start_time!.addingTimeInterval(-1800)
        app.registerUserNotificationSettings(notificationSettings)
        notifyAlarm.fireDate = alertTime as Date
        notifyAlarm.timeZone = TimeZone.ReferenceType.default
        notifyAlarm.soundName = soundName
        notifyAlarm.alertBody = "출발하세요!! 막차 시간 " + String(describing: first_start_time) + "입니다."
        app.scheduleLocalNotification(notifyAlarm)
    }
    
    
}
