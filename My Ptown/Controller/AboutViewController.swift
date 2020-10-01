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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = aboutTableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as! AboutTableViewCell
        if indexPath.row == 0 {
            cell.setView(title: "Enjoying the app?", description: "Write a review for us", image: UIImage(systemName: "star.circle.fill"))
            
        } else if indexPath.row == 1 {
            cell.setView(title: "Do you have any request or suggestion? ", description: "Send us an e-mail", image: UIImage(systemName: "envelope.circle.fill"))
        } else if indexPath.row == 2 {
            cell.setView(title: "We're on Instagram!", description: "Follow us to keep updated on whats new", image: UIImage(systemName: "camera.circle.fill"))
        } else {
            cell.setView(title: "Share the app! ", description: "Share the app with your friends", image: UIImage(systemName: "arrow.up.right.circle.fill"))
        }
        return cell
    }
}

//MARK: -UITableViewDelegate
extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            aboutViewModel.openAppStore()
        } else if indexPath.row == 1{
            aboutViewModel.sendAnEmail()
        } else if indexPath.row == 2{
            aboutViewModel.openInstagram()
        } else {
            guard let url = URL(string: "https://apps.apple.com/us/app/my-ptown/id1527977001") else { return }
            let shareContent = [url]
            let activityController = UIActivityViewController(activityItems: shareContent, applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
    }
}
