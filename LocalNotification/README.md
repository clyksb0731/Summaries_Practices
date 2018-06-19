`Swift` `UserNotifications`

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
주로 앱이 처음 실행 될 때 요청된다.  
따라서 ```AppDelegate.swift```의 didFinishLaunchingWithOptions 함수에 아래와 같이 추가한다.  
shared UNUserNotificationCenter object로서 current() 메소드를 이용하여 instance에 접근한다.

```swift
let center = UNUserNotification.current()
center.requestAuthorization(options: [.alert, .sound, .badge]) {
    granted, error in
    if granted {

    }
}
```
> 네 가지의 notification 종류 `UNAuthorizationOptions.alert`, `.sound`, `.badge`, `.carPlay` 가 있고 위 code와 같이 UNAuthorizationOptions의 배열 요소로서 사용한다.

2. Notification Setting  


3. Creating Notification Request


    - Notification Content


    - Notification Trigger


        - Time Interval
        - Calendar
        - Location
    - Notification Scheduling
4. Custom Actions
5. The Notification Delegate
6. Managing Pending and Delivered Notification
