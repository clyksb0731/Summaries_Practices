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

