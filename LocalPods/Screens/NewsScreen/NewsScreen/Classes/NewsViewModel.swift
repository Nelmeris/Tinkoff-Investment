//
//  NewsViewModel.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import FormattersKit

struct NewsViewModel: Identifiable {
    let id: Int
    let imageURL: URL
    let headline: String
    let summary: String
    let date: String
    let url: URL
}

class NewsViewModelFactory {

    func make(from models: [News]) -> [NewsViewModel] {
        return models.map(make)
    }

    func make(from model: News) -> NewsViewModel {
        let id = model.id
        let imageURL = model.image
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
