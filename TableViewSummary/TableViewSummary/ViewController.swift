//
//  ViewController.swift
//  TableViewSummary
//
//  Created by 최용석 on 11/10/2018.
//  Copyright © 2018 최용석. All rights reserved.
//

import UIKit

// UIColor Customized
extension UIColor {
    class func getRGB(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
    
    // Need to check if P3 has 10bit * 3 color
    class func getDisplayP3(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(displayP3Red: CGFloat(red / 1023), green: CGFloat(green / 1023), blue: CGFloat(blue / 1023), alpha: 1)
    }
}

// View Controller Present Style
enum PresentStyle {
    case modally
    case push
}

class ViewController: UIViewController {
    
    var viewControllers: Array<StyledViewController> = []
    var viewControllerTable: UITableView!
    
    var safeGuide: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.safeGuide = self.view.safeAreaLayoutGuide
        self.setViewController()
        self.createViewControllerList()
        self.setAnchor()
        
        self.makeViewControllerList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setViewController() {
        self.navigationItem.title = "ViewControllers"
        // The backBarButtonItem affect only pushed view controllers only when leftBarButton doesn't exist.
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.getRGB(red: 1, green: 1, blue: 1)
        // Title or image can be replaced instead of original word, 'Back'.
        self.navigationItem.backBarButtonItem?.title = "Back" // Choose only one between title and image
        //        self.navigationItem.backBarButtonItem?.image = UIImage(named: "back")
    }
    
    // MARK: Create Table
    func createViewControllerList() {
        self.viewControllerTable = UITableView()
        
        self.viewControllerTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.viewControllerTable)
        
        viewControllerTable.delegate = self
        viewControllerTable.dataSource = self
        viewControllerTable.register(TableViewCell.self, forCellReuseIdentifier: "vc_info")
    }
    
    // MARK: Set Layout of Table
    func setAnchor() {
        self.viewControllerTable.leadingAnchor.constraint(equalTo: self.safeGuide.leadingAnchor).isActive = true
        self.viewControllerTable.trailingAnchor.constraint(equalTo: self.safeGuide.trailingAnchor).isActive = true
        self.viewControllerTable.topAnchor.constraint(equalTo: self.safeGuide.topAnchor).isActive = true
        self.viewControllerTable.bottomAnchor.constraint(equalTo: self.safeGuide.bottomAnchor).isActive = true
    }
}

// MARK: Add View Controllers onto Table List
extension ViewController {
    func makeViewControllerList() {
        self.addViewController(LogInViewController(), with: "login View controller", presentStyle: .modally)
    }
    
    func addViewController(_ vc: UIViewController, with name: String, presentStyle: PresentStyle) {
        let styledVC: StyledViewController = StyledViewController(vc, name: name, presentStyle: presentStyle)
        self.viewControllers.append(styledVC)
    }
}

// MARK: - Extension for the list of view controllers
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "vc_info", for: indexPath) as! TableViewCell
        
        cell.sequence.text = String(indexPath.row + 1)
        cell.viewControllerName.text = self.viewControllers[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    // TODO: To test constraints on UIView directly
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        <#code#>
    //    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Footer"
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If some content inside cell, use under syntax. But not for current syntax
        // let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        
        switch self.viewControllers[indexPath.row].presentStyle {
        case .modally:
            self.present(self.viewControllers[indexPath.row].vc, animated: true)
        case .push:
            self.navigationController?.pushViewController(self.viewControllers[indexPath.row].vc, animated: true)
        }
        
        // Deselet row of table list
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
