//
//  Movies.swift
//  APPSeries
//
//  Created by Mendes, Mafalda Joana on 10/05/2022.
//

import Foundation

struct MoviesResponse: Codable {
    let items: [Movie]?
    let results: [Movie]?
}

struct Movie: Codable {
    let id: String?
    let crew: String?
    let title: String?
    let fullTitle: String?
    let image: String?
    let imDbRating: String?
    let imDbRatingCount: String?
    let rank: String?
    let rankUpDown: String?
    let year: String?
    let releaseState: String?
    let runtimeMins: String?
    let runtimeStr: String?
    let plot: String?
    let description: String?
    let contentRating: String?
    let metacriticRating: String?
    let genres: String?
    let genresList: [Genres]?
    let directors: String?
    let directorsList: [Directors]?
    let stars: String?
    let starsList: [Stars]?
}

struct Genres: Codable {
    let key: String?
    let value: String?
}

struct Directors: Codable {
    let id: String?
    let name: String?
}

struct Stars: Codable {
    let id: String?
    let name: String?
}
