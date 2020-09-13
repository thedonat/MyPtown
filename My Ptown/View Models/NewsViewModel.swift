//
//  NewsViewModel.swift
//  My Ptown
//
//  Created by Burak Donat on 13.09.2020.
//  Copyright © 2020 Burak Donat. All rights reserved.
//

import Foundation

protocol NewsListViewModelProtocol: class {
    func didGetNewsArticles()
}

class NewsListViewModel {
    weak var delegate: NewsListViewModelProtocol?
    var newsArticles: [Article?] = []
    var numberOfRows: Int {
        return newsArticles.count
    }
    func cellForRow(at index: Int) -> NewsViewModel? {
        if let newsArticle = self.newsArticles[index] {
            return NewsViewModel(news: newsArticle)
        }
        return nil
    }
    func getNewsArticles() {
        let url = "https://newsapi.org/v2/everything?q=provincetown&from=2020-08-13&sortBy=publishedAt&apiKey=fa68fee749e04314a452180019ed7fae"
        WebService().performRequest(url: url) { (news: NewsData) in
            print(news.articles)
            self.newsArticles = news.articles
            self.delegate?.didGetNewsArticles()
        }
    }
}

struct NewsViewModel {
    let news: Article

//    var author: String? {
//        return news.author
//    }
    var title: String {
        return news.title
    }
    var articleDescription: String? {
        return news.description
    }
    var url: String {
        return news.url
    }
    var urlToImage: String? {
        return news.urlToImage
    }
    var publishedAt: String {
        return news.publishedAt
    }
    var content: String {
        return news.content
    }
    var sourceName: String {
        return news.source.name
    }
}
