//
//  ViewController.swift
//  MapKitSample
//
//  Created by 최용석 on 27/05/2019.
//  Copyright © 2019 최용석. All rights reserved.
//

import UIKit
import Contacts
import MapKit

class ViewController: UIViewController {
    
    
    //1.스토리 보드에서 만든 객체들을 컨트롤러와 연결시켜주었다.
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    
    
    //2. 사용자가 주소를 입력하고 getDirections 버튼을 누르면 해당메서드는 필드들에 있는 주소 정보를 추출한다.
    /*이렇게 하는 목적은 입력한 위치를 가진 MKPlacemark 객체를 생성하기 위한 것이다.
     MKPlacemark 인스턴스는 인스턴스화 되기 전에 주소에 대한 위도와 경도가 필요하다.
     getDirectoin 메서드의 첫번째 단계는 주소에 대한 순방향 지오코드 변환을 수행하는 것이다.
     이렇게 하기전에 계산된 좌표들을 저장할 속성 하나를 이곳에 선언해야 한다.
     따라서 CoreLocation 프레임 워크를 임포트 해야 한다.*/
    
    var coords: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getDirections(_ sender: AnyObject) {
        
        //One Infinite Loop, Cupertino, CA 95014
        let addressString = "\(address.text ?? "") \(city.text ?? "") \(state.text ?? "") \(zip.text ?? "")"
        
        print(addressString)
        
        //3.지오코딩 변환을 수행하는 소스 코드
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("에러 발생: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    self.coords = location!.coordinate
                    print("Location:: ", location)
                    
                    //4.showMap을 호출 한다.
                    self.showMap()
                    
                }
        })
        
    }
    
    //5. 이 메서드는 목저지 주소에 대한 새로운 MKPlacemark 인스턴스를 생성하고, 거기에 드라이브 길찾기를 위한 옵션들을 설정한다음 지도를 실행한다.
    
    
    func showMap() {
        
        //텍스트 주소를 딕셔너리 형태로 저장
        let addressDict =
            [CNPostalAddressStreetKey: address.text!,
             CNPostalAddressCityKey: city.text!,
             CNPostalAddressStateKey: state.text!,
             CNPostalAddressPostalCodeKey: zip.text!]
        
        //주소 딕셔너리와 좌표를 이용해서 MKPlacemark 인스턴스 생성
        let place = MKPlacemark(coordinate: coords!,
                                addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: place)
        
        //옵션 설정
        let options = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        
        mapItem.openInMaps(launchOptions: options)
    }
    
    
}


