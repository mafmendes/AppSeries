//
//  MovieListDomain.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 03/06/2022.
//

import Foundation

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: TableViewCell, viewModel: MovieDetail)
}

enum Sections: Int {
    case mostPopular = 0
    case top250Movies = 1
    case inTheaters = 2
    case commingSoon = 3
}
enum MovieListConstants {
    static var sectionTitles: [String] {  ["Most Popular", "Top 250 Movies", "In theaters", "Comming Soon"]}
    static var tableIdentifier = "CollectionViewTableViewCell"
    static var cellIdentifier = "CollectionViewCell"
}

enum StorageKeys: String {

    case searchBarStorageKey = "RecentSearch"

}
