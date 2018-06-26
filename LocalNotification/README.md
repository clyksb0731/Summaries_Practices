`Swift` `UserNotifications`

# Local Notification

iOS 10.0 이상부터 Local Notification을 사용하려면 `UserNotifications` 프레임워크를 사용해야 한다.
```swift
if #available (iOS 10.0, *) {

}
```

## Import Framework

```swift
import UserNotification
```

## Request Authorization  
Local Notification, 즉 알림을 사용하기 위해서는 권한을 획득해야 하는데 아래의 code와 같이 요청한다. 주로 앱이 처음 실행 될 때 요청하는데, 따라서 ```AppDelegate.swift```의 didFinishLaunchingWithOptions 메소드에 위치한다. shared object로서 `UNUserNotificationCenter` class의 current() 메소드를 통해 그 instance에 접근한다.  

```swift
let center = UNUserNotification.current()
center.requestAuthorization(options: [.alert, .sound, .badge]) {
    granted, error in
    if granted {

    }
}
```
> 1. 네 가지의 notification 종류 `UNAuthorizationOptions.alert`, `.sound`, `.badge`, `.carPlay` 옵션이 있고 위 code와 같이 UNAuthorizationOptions의 배열 요소로서 사용되어 권한을 획득한다.  
> 2. .alert은 배너 알림의 추가, .sound는 사운드 알림 추가, .badge는 배지 알림 추가, .carPlay는 CarPlay 환경에서 알림을 표시하는 옵션이다. 없는 옵션 요소는 설정앱에서 스위치를 볼 수 없다.

## Notification Setting  
- `UNUserNotificationCenter` instance의 getNotificationSettings(completionHandler:) 메소드를 호출하여 Notification Settings 접근한다.  
- 어느 때든 앱의 알림의 설정을 수정할 수 있다. 권한을 확인하고 개개의 알림을 수정한다.

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

## Creating Notification Request  
Notification Request는 Notification Content와 Notification Trigger를 포함한다.

```swift
let content = UNMutableNotificationContent()
let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: false)
let request = UNNotificationRequest(indetifier: "requestID", content: content, trigger: trigger)
```
> 내용이 없는 content와 (사실 아래와 같은 요소들을 필요에 맞게 넣어야 함) 이벤트 발생의 시점을 정하는 trigger (위 code에서는 add 후에 300초 후에 알림이 실행되고 반복되지는 않는다.)를 이용하여 Notification Request를 생성한다. 고유 identifier를 갖는다.

## Mutable Notification Content  
알림에 대한 컨텐츠로서 `UNMutableNotificationContent`의 instance이고 아래의 속성들을 갖는다.
- title
- subtitle
- body
- badge
- sound
- launchImageName
- userInfo
- attachments  

**_👉🏻 need to be updated more this section_**


## Notification Trigger  
일정 시간 / 날짜 및 시간 / 위치정보에 의한 트리거  
1. Time Interval  
    일정 시간 후의 알림에 대한 트리거
    ```swift
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: false)
    ```

2. Calendar  
    날짜 및 시간에 대한 트리거로서 date component object를 이용한다.  
    ```swift
    // The specific generated date the designated seconds since now.
    let date = Date(timeIntervalSinceNow: 3600)
    // Acquire year, month, day, hour, minute, second as date component from the specific date
    let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    // Use date component as a trigger
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    ```

3. Location  
    트리거로서 지리적 지역을 사용하는데 그 지역을 들어가거나 떠날 때 작용한다. Core Location을 통해 생성된다. `CLRegion` 

    **_👉🏻 need to be updated more this section_**

## Notification Scheduling  
- `UNUserNotificationCenter` shared instance의 add(_:withCompletionHandler:) 메소드를 통해 생성된 request를 notification center에 등록한다.  
- 여러 request를 등록할 때 모든 request는 각기 다른 identifier를 가져야하며 이미 존재하는 identifier로 새로운 request를 등록하려 한다면 새로운 request로 교체된다.  

```swift
let request = UNNotificationRequest(indetifier: "requestID", content: content, trigger: trigger)
center.add(request, withCompletionHandler: { (error) in
  // Unwrapping optional of error
  if let error = error {
    // Something went wrong
  }
})
```

## Custom Actions  
- 알림에 대해 앱이 실행할 작업.  
- Notification Action을 생성 한 후 `UNNotificationCategory`의 object에 등록하고 이 Notification Category를 `UNUserNotificationCenter` shared instance에 등록한다. 이 과정은 앱 구동 초기에 진행되는 것이 권장된다.  
- 앱의 모든 Notification Category는 `UNUserNotification`의 shared instance의 setNotificationCategories(_:) 메소드를 통해 한번에 동시에 등록되어야 하고 이 메소드를 다시 호출하여 새로 등록한다면 새로운 Notification Category로 교체된다. 일반적으로 한번만 동록한다.  
- 알림의 Notification Action이 선택 될 때 `UNUserNotificationCenterDelegate'의 userNotificationCenter(_:didReceive:withCompletionHandler:) 메소드가 호출된다. 
```swift
// title: the title of the notification delivered
let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
let deleteAction = UNNotificationAction(identifier: "delete", title: "Delete", options: [.destructive])

let category = UNNotificationCategory(identifier: "categoryID", actions: [snoozeAction,deleteAction], intentIdentifiers: [], options: [])

center.setNotificationCategories([category])
```
> 생성된 Notification Action / Notification Category를 특정 알림에 적용하려면 그 알림(`UNMutableNotificationContent`의 instance)의 categoryIdentifier 속성에 Notification Category identifier를 저장한다.  
`UNTextInputNotificationAction`을 사용하여 text input action을 생성 할 수 있다.  
**_👉🏻 need to be updated more this section_**

## The Notification Delegate  
- 알림의 액션을 선택하거나 앱이 실행 중일 때 알림을 처리하는 delegate.  
- 앱 구동이 끝나기 전에 delegate object를 `UNUserNotificationCenter` shared instance에 할당해야 한다.  
- 아래와 같은 두개의 optional method를 구현 할 수 있다.
    1. func userNotificationCenter(_:didReceive:withCompletionHandler:)  
    알림이 왔을 때 사용자에 의해 선택된 액션을 처리 할 때 사용하는 메소드.
    2. func userNotificationCenter(_:willPresent:withCompletionHandler:)  
    앱이 구동 중일 때 도착한 알림을 처리하는 메소드.  
    ```swift
    /* 1-1. userNotificationCenter(_:didReceive:withCompletionHandler:) */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Get the meeting ID from the original notification.
        let userInfo = response.notification.request.content.userInfo
        
        if response.notification.request.content.categoryIdentifier == "MEETING_INVITATION" {
            // Retrieve the meeting details.
            let meetingID = userInfo["MEETING_ID"] as! String
            let userID = userInfo["USER_ID"] as! String
            
            switch response.actionIdentifier {
            case "ACCEPT_ACTION":
                sharedMeetingManager.acceptMeeting(user: userID, meetingID: meetingID)

            case "DECLINE_ACTION":
                sharedMeetingManager.declineMeeting(user: userID, meetingID: meetingID)
            
            case UNNotificationDefaultActionIdentifier, UNNotificationDismissActionIdentifier:
                // Queue meeting-related notifications for later
                //  if the user does not act.
                sharedMeetingManager.queueMeetingForDelivery(user: userID, meetingID: meetingID)
            
            default:
                break
            }
        } else {
            // Handle other notification types...
        }
        
        // Always call the completion handler when done.
        completionHandler()
    }

    /* 1-2. userNotificationCenter(_:didReceive:withCompletionHandler:) */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Determine the user action
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")  
        default:
            print("Unknown action")
        }
        completionHandler()
    }

    /* 2. userNotificationCenter(_:willPresent:withCompletionHandler:) */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void {
        if notification.request.content.categoryIdentifier == "MEETING_INVITATION" {
            // Retrieve the meeting details.
            let meetingID = notification.request.content.userInfo["MEETING_ID"] as! String
            let userID = notification.request.content.userInfo["USER_ID"] as! String
            
            // Add the meeting to the queue.
            sharedMeetingManager.queueMeetingForDelivery(user: userID, meetingID: meetingID)
            
            // Play a sound to let the user know about the invitation.
            completionHandler(.sound)
            return
        } else {
            // Handle other notification types...
        }
                
        // Don't alert the user for other types.
        completionHandler(UNNotificationPresentationOptions(rawValue: 0))
    }
    ```
    > - userNotificationCenter(_:didReceive:withCompletionHandler:)일 때 매개변수 response에는 original notification과 Notification Action의 identifier가 포함된다. (textual response도 가능하다.)
    >   - 또한 사용자의 반응에 대한 처리를(구현) 끝낼 때는 반드시 completionHandler() 메소드를 호출한다.
    > * userNotificationCenter(_:willPresent:withCompletionHandler:)일 때 매개변수 notification에는 original notification이 포함된다.
    >   * 또한 항상 completionHandler(_: UNNotificationPresentationOptions)을 호출해야 하는데 이 클로져를 통해서 사용자에게 notification에 대해 알릴 수 있다. 가능한 값은 .badge, .sound, .alert 혹은 이 값들의 list다. [.badge, .sound]
    >   * 아무것도 알리지 않으려고 할 때는 `completionHandler(UNNotificationPresentationOptions(rawValue: 0))` 구문을 사용한다.

## Managing Pending and Delivered Notification  
아직 나타나지 않았거나 notification center에 이미 나타난 알림들을 관리한다.
1. Pending Notification Requests  
    1. getPendingNotificationRequests(completionHandler:)  
    아직 나타나지 않은 알림의 Notification Request들을 불러와서 클로져로 넘겨 처리한다.
    2. removePendingNotificationRequests(withIdentifiers:)  
    아직 나타나지 않은 알림을 취소(unschedule)한다. 매개변수 identifiers는 Notification Request의 identifier들을 받는다. 이미 나타났거나 나타났고 반복되지 않는 알림은 무시된다.
    3. removeAllPendingNotificationRequests()  
    모든 나타나지 않은 알림이 취소된다.

2. Delivered Notifications  
    1. getDeliveredNotifications(completionHandler:)  
    notification center에 나타난 알림들을 불러와서 클로져에 넘겨 처리한다.
    2. removeDeliveredNotifications(withIdentifiers:)  
    Notification Request의 identifier를 이용하여 notification center에 나타난 알림을 없앤다. 매개변수 identifiers는 NSString의 배열로 이뤄진다. 만일 이미 notification center에서 지워진 알림의 Notification Request idetifier가 사용된다면 무시된다.
    3. removeAllDeliveredNotifications()  
    notification center에 나타난 모든 알림을 없앤다.

