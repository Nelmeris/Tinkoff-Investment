//
//  NewsViewModel.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import FormattersKit
import FinnhubDataManager

public struct NewsViewModel: Identifiable {
    public let id: Int
    public let imageURL: URL?
    public let headline: String
    public let summary: String
    public let date: String
    public let url: URL
    
    public init(id: Int,
                imageURL: URL?,
                headline: String,
                summary: String,
                date: String,
                url: URL) {
        self.id = id
        self.imageURL = imageURL
        self.headline = headline
        self.summary = summary
        self.date = date
        self.url = url
    }
}

public class NewsViewModelFactory {
    
    public init() {}

    public func make(from models: [News]) -> [NewsViewModel] {
        return models.map(make)
    }

    public func make(from model: News) -> NewsViewModel {
        let id = model.id
        let imageURL = URL(string: model.image)
        let headline = model.headline
        let summary = model.summary
        let dateFormatter = DateFormatter.unix(with: .newsFeedCell)
        let dateStr = dateFormatter.string(fromUnixTimestamp: model.datetime)
        let url = model.url
        return NewsViewModel(id: id,
                             imageURL: imageURL,
                             headline: headline,
                             summary: summary,
                             date: dateStr,
                             url: url)
    }

}
