//
//  Menu.swift
//  TechFetch
//
//  Created by Jason Park on 2/11/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit

class Menu {
    
    let darkView = UIView()
    
    public func openMenu() {
        if let window = UIApplication.shared.keyWindow {
            darkView.frame = window.frame
            darkView.backgroundColor = UIColor(white: 0, alpha: 0.3)
            
            darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeMenu)))
            
            window.addSubview(darkView)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.darkView.alpha = 1
            })
        }
    }
    
    @objc public func closeMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            self.darkView.alpha = 0
        })
    }
    
    
}
