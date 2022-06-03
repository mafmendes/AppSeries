//
//  MovieListViewModel.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 03/06/2022.
//

import Foundation
import UIKit

final class MovieListViewModel {
    func configureRows(indexPath: IndexPath, cell: TableViewCell) {
        switch indexPath.section {
        case Sections.mostPopular.rawValue:
            APICaller.shared.getMostPopularMovies { result in
                switch result {
                case .success(let moviesInfo):
                    cell.configure(with: moviesInfo)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.top250Movies.rawValue:
            APICaller.shared.getTop250Movies { result in
                switch result {
                case .success(let moviesInfo):
                    cell.configure(with: moviesInfo)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.inTheaters.rawValue:
            APICaller.shared.getInTheaters { result in
                switch result {
                case .success(let moviesInfo):
                    cell.configure(with: moviesInfo)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.commingSoon.rawValue:
            APICaller.shared.getCommingSoonMovies { result in
                switch result {
                case .success(let moviesInfo):
                    cell.configure(with: moviesInfo)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            UITableViewCell()
        }
    }
    func reload(self: SearchResultsViewControllerDelegate,
                searchBar: UISearchBar, searchController: UISearchController, defaults: UserDefaults) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            return
        }
        let searchBar = searchController.searchBar
        guard let movie = searchBar.text,
              !movie.trimmingCharacters(in: .whitespaces).isEmpty,
              movie.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController
        else {
                  return
              }
        resultsController.activityIndicator.startAnimating()
        APICaller.shared.searchMovie(with: movie) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    defaults.set(searchBar.text, forKey: "RecentSearch")
                    resultsController.delegate = self
                    resultsController.movies = movie
                    resultsController.searchResultsCollectionView.reloadData()
                    resultsController.activityIndicator.stopAnimating()
                    if resultsController.movies.count == 0 {
                        resultsController.noResultsLabel.text = "Your search has no results. Try again!"
                    } else {
                        resultsController.noResultsLabel.text = ""
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
