`Swift` `UserNotifications`

# Local Notification

iOS 10.0 이상부터 Local Notification을 사용하려면 `UserNotifications` 프레임워크를 사용해야 한다.
```swift
if #available (iOS 10.0, *) {

}
```

0. Import Framework

```swift
import UserNotification
```

1. Authorization  
Local Notification, 즉 알림을 사용하기 위해서는 권한을 획득해야 하는데 아래의 code와 같이 요청한다.  
주로 앱이 처음 실행 될 때 요청하는데, 따라서 ```AppDelegate.swift```의 didFinishLaunchingWithOptions 메소드에 위치한다.  
shared object로서 `UNUserNotificationCenter` class의 current() 메소드를 통해 그 instance에 접근한다.  

```swift
let center = UNUserNotification.current()
center.requestAuthorization(options: [.alert, .sound, .badge]) {
    granted, error in
    if granted {

    }
}
```
> 네 가지의 notification 종류 `UNAuthorizationOptions.alert`, `.sound`, `.badge`, `.carPlay` 옵션이 있고 위 code와 같이 UNAuthorizationOptions의 배열 요소로서 사용되어 권한을 획득한다.  
.alert은 배너 알림의 추가, .sound는 사운드 알림 추가, .badge는 배지 알림 추가, .carPlay는 CarPlay 환경에서 알림을 표시하는 옵션이다. 없는 옵션 요소는 설정앱에서 스위치를 볼 수 없다.

2. Notification Setting  
`UNUserNotificationCenter` instance의 getNotificationSettings(completionHandler:) 메소드를 호출하여 Notification Settings 접근한다.  
어느 때든 앱의 알림의 설정을 수정할 수 있다. 권한을 확인하고 개개의 알림을 수정한다.

```swift
center.getNotificationSettings {
    settings in
    // if notification is authorized
    if settings.authorizationStatus = .authorized {
        // if badge in notification is turned on
        if settings.badgeSetting = .enable {
            // write code whether badge is on
        }
    }
}
```

3. Creating Notification Request  
Notification Request는 Notification Content와 Notification Trigger를 포함한다.

```swift
let content = UNMutableNotificationContent()
let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: false)
let request = UNNotificationRequest(indetifier: "requestID", content: content, trigger: trigger)
```
> 내용이 없는 content와 (사실 아래와 같은 요소들을 필요에 맞게 넣어야 함) 이벤트 발생의 시점을 정하는 trigger (위 code에서는 add 후에 300초 후에 알림이 실행되고 반복되지는 않는다.)를 이용하여 Notification Request를 생성한다. 고유 identifier를 갖는다.

- Mutable Notification Content  
알림에 대한 컨텐츠로서 `UNMutableNotificationContent`의 instance이고 아래의 속성들을 갖는다.
    - title
    - subtitle
    - body
    - badge
    - sound
    - launchImageName
    - userInfo
    - attachments
    
- Notification Trigger  
일정 시간 / 날짜 및 시간 / 위치정보에 의한 트리거
    - Time Interval  
    일정 시간 후의 알림에 대한 트리거
    ```swift
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: false)
    ```
    
    - Calendar  
    날짜 및 시간에 대한 트리거로서 date component object를 이용한다.  
    ```swift
    // 현재로부터 일정 초 지난 후의 날
    let date = Date(timeIntervalSinceNow: 3600)
    let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    ```

    - Location  

- Notification Scheduling  


4. Custom Actions
5. The Notification Delegate
6. Managing Pending and Delivered Notification
