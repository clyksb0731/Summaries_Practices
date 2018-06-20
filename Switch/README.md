`Swift` `UIKit`

# UISwitch

fixed size: 31 X 51 (가로 X 세로)
> 디자인 할 때는 강제로 사이즈를 변경 할 수 있을지라도 구동 시에는 고정 사이즈로 돌아간다.

## Layout

1. Center  
size 없이 view나 AreaLayoutGuide의 X Y center에 UISwitch object를 위치시킨다.
```swift
let safeGuide = self.view.safeAreaLayoutGuide
        
// set object on the center of X and Y
let sw1 = UISwitch()
sw1.translatesAutoresizingMaskIntoConstraints = false
self.view.addSubview(sw1)
        
// sw1.heightAnchor.constraint(equalToConstant: 31).isActive = true
// sw1.widthAnchor.constraint(equalToConstant: 51).isActive = true
safeGuide.centerXAnchor.constraint(equalTo: sw1.centerXAnchor).isActive = true
safeGuide.centerYAnchor.constraint(equalTo: sw1.centerYAnchor).isActive = true
```

2. Position  
top / leading과 같이 NSLayoutYAxisAnchor / NSLayoutXAxisAnchor (Y, X 축) 각각 최소 하나 이상 constraint로 위치시킨다.
```swift
let sw2 = UISwitch()
sw2.translatesAutoresizingMaskIntoConstraints = false
self.view.addSubview(sw2)
        
safeGuide.topAnchor.constraint(equalTo: sw2.topAnchor, constant: -100).isActive = true
// safeGuide.bottomAnchor.constraint(equalTo: , constant: ).isActive = true
safeGuide.leadingAnchor.constraint(equalTo: sw2.leadingAnchor, constant: (-375+51)/2).isActive = true
// safeGuide.trailingAnchor.constraint(equalTo: , constant: ).isActive = true
```

## Event Handling
1. Generate event  
스위치를 터치함으로써 On -> Off (혹은 Off -> On) 로 변경 할 수 있다. `UIControlEvents`의 값은 .valueChanged이다.  
```swift
// in a method to be run
sw2.addTarget(self, action: #selector(reactForSW(_:)), for: .valueChanged)

// Target method in the different method
@objc func reactForSW(_ sender: UISwitch) {
        if sender.isOn {
            print("On")
            print(sender)
        } else {
            print("Off")
            print(sender)
        }
    }
```

2. Set state On / Off  
스위치 상태를 On 혹은 Off로 변경 하는 메소드.
```swift
// Switch On
sw2.setOn(true, animated: true)

// Switch Off
sw2.setOn(false, animated: true)
```

3. State  
스위치 상태를 On 혹은 Off로 변경할 수 있고 그 상태를 얻을 수 있는 속성으로서 애니메이션 효과를 넣을 수는 없다.
```swift
// set the state of switches to On or Off
sw1.isOn = true
sw2.isOn = false

// to get bool value from isOn property
if sw1.isOn && sw2.isOn {
            self.sw1.setOn(false, animated: true)
            self.sw2.setOn(false, animated: false)
}
```