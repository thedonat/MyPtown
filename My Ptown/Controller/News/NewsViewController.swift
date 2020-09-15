//
//  NewsViewController.swift
//  My Ptown
//
//  Created by Burak Donat on 13.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    //MARK: -Properties
    @IBOutlet weak var newsTableView: UITableView!
    let newsListViewModel: NewsListViewModel = NewsListViewModel()
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
    }
    //MARK: -Helpers
    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getData(){
        newsListViewModel.delegate = self
        newsListViewModel.getNewsArticles()
    }
}
//MARK: -UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsListViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = newsListViewModel.cellForRow(at: indexPath.row)
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.setView(title: vm?.title,
                     description: vm?.articleDescription,
                     source: vm?.sourceName,
                     imageUrl: vm?.urlToImage)
        return cell
    }
}
//MARK: -NewsListViewModelProtocol
extension NewsViewController: NewsListViewModelProtocol {
    func didGetNewsArticles() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
}
