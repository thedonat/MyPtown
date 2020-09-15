//
//  AboutViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 13.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    //MARK: -Properties
    @IBOutlet weak var aboutTableView: UITableView!
    let aboutViewModel: AboutViewModel = AboutViewModel()
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: -Helpers
    private func configureUI() {
        self.aboutTableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
//MARK: -UITableViewDataSource
extension AboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = aboutTableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as! AboutTableViewCell
        if indexPath.row == 0 {
            cell.setView(title: "Enjoying the app?", description: "Write a review for us", image: UIImage(systemName: "star.fill"))
            
        } else if indexPath.row == 1 {
            cell.setView(title: "Do you have any request or suggestion? ", description: "Send us an e-mail", image: UIImage(systemName: "envelope.fill"))
        } else {
            cell.setView(title: "We're on Instagram!", description: "Follow us to keep updated on whats new", image: UIImage(systemName: "camera.fill"))
        }
        return cell
    }
}
//MARK: -UITableViewDelegate
extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            aboutViewModel.openAppStore()
        } else if indexPath.row == 1{
            aboutViewModel.sendAnEmail()
        } else {
            aboutViewModel.openInstagram()
        }
    }
}
