//
//  AboutViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 13.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

struct AboutViewModel {
    func openAppStore() {
        let url = "https://apps.apple.com/us/app/my-ptown/id1527977001"
        if let path = URL(string: url) {
                UIApplication.shared.open(path, options: [:], completionHandler: nil)
        }
    }
    func sendAnEmail() {
        let url = "burakdonat@gmail.com"
        if let path = URL(string: "mailto:\(url)") {
            UIApplication.shared.open(path, options: [:], completionHandler: nil)
        }
    }
    func openInstagram() {
        let url = "https://www.instagram.com/myptownn/"
        if let path = URL(string: url) {
            UIApplication.shared.open(path, options: [:], completionHandler: nil)
        }
    }
}
