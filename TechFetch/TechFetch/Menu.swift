//
//  Menu.swift
//  TechFetch
//
//  Created by Jason Park on 2/11/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit

class Menu: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let darkView = UIView()
    let menuTableView = UITableView()
    let arrayOfSources = ["TechCrunch", "TechRadar"]
    var mainVC: ViewController?
    
    public func openMenu() {
        if let window = UIApplication.shared.keyWindow {
            darkView.frame = window.frame
            darkView.backgroundColor = UIColor(white: 0, alpha: 0.3)
            
            darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeMenu)))
            
            let height: CGFloat = 100
            
            let y = window.frame.height - height
            
            menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            window.addSubview(darkView)
            window.addSubview(menuTableView)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.darkView.alpha = 1
                self.menuTableView.frame.origin.y = y
            })
        }
    }
    
    @objc public func closeMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            self.darkView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.menuTableView.frame.origin.y = window.frame.height
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as UITableViewCell
        cell.textLabel?.text = arrayOfSources[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = mainVC {
            vc.source = arrayOfSources[indexPath.item]
            vc.fetchArticles(fromSource: vc.source)
            closeMenu()
        }
    }
    
    
    override init() {
        super.init()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.isScrollEnabled = false
        menuTableView.bounces = false
        
        menuTableView.register(BaseViewCell.classForCoder(), forCellReuseIdentifier: "cellId")
    }
    
    
}
