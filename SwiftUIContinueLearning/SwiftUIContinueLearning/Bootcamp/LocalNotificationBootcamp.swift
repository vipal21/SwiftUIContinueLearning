//
//  LocalNotificationBootcamp.swift
//  SwiftUIContinueLearning
//
//  Created by Vipal on 29/09/22.
//

import SwiftUI
import UserNotifications
import CoreLocation
final class NotificationManager{
    private init(){}
    static let instance = NotificationManager() // singleton
    let options: UNAuthorizationOptions = [.alert,.sound,.badge]
    
    func requestAuthorization () {
        UNUserNotificationCenter.current().requestAuthorization(options: options) { sucess, error in
            if let error = error {
                print(error)
            }else {
                print("Sucess")
            }
        }
    }
    func scheduleNotification (){
        let content = UNMutableNotificationContent()
        content.title = "This istitle"
        content.subtitle = "This is subtitle"
        content.sound = .default
        content.badge = 1
        //time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        // clander
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        dateComponents.minute = 28
//        dateComponents.weekday = 1 // for particular day
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //location
        let coordinate = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        let region = CLCircularRegion(center: coordinate,
                                      radius: 50,
                                      identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger:trigger )
        UNUserNotificationCenter.current().add(request)

    }
    func cancleNotification (){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack {
            Button("Requestpermission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schdule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancle Notification") {
                NotificationManager.instance.cancleNotification()
            }
        }.onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
