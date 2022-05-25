//
//  ViewController.swift
//  DemoNotification
//
//  Created by Vu Thanh Nam on 16/05/2022.
//

import UIKit
import UserNotifications

class ViewController : UIViewController,UNUserNotificationCenterDelegate {
    
    
    @IBAction func btnNext(_ sender: UIButton) {
        initNotification()
    }
    let centerNotification = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        centerNotification.delegate = self
       
    }

    func initNotification(){
        //create permission
       
        centerNotification.requestAuthorization(options: [.alert,.badge,.sound]){
            (success,error) in
        }
        //create content
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "This is first demo Notification"
        content.categoryIdentifier = "My category identifier"
        content.sound = UNNotificationSound.defaultRingtone
        content.badge = 5
        //create image notification
        let url = Bundle.main.url(forResource: "7", withExtension: "jpg")
        let attachment = try! UNNotificationAttachment(identifier: "image", url: url!, options:[:]  )
            content.attachments = [attachment]
        let identifier = "My Identifier"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        centerNotification.add(request){
            (error1) in
            print("\(error1?.localizedDescription)")
        }
        let see = UNNotificationAction.init(identifier: "See", title: "See", options: .foreground)
        let reply = UNNotificationAction.init(identifier: "Reply", title: "Reply", options: .destructive)
        let category = UNNotificationCategory.init(identifier: content.categoryIdentifier, actions: [see, reply], intentIdentifiers: [], options: [])
        centerNotification.setNotificationCategories([category])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondScreen = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        self.navigationController?.pushViewController(secondScreen, animated: true)
    }


    
}


