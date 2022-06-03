//
//  MovieListController.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 03/06/2022.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {

    private let moviesTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(TableViewCell.self, forCellReuseIdentifier: tableIdentifier)
        return table
    }()
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a movie"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    private var didTapDeleteKey = false
    private let defaults = UserDefaults.standard
    private let viewModel: MovieListViewModel = MovieListViewModel()
    init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpTableView()
        view.addSubview(moviesTable)
        setUpSearchController()
    }
    private func setUpTableView() {
        moviesTable.delegate = self
        moviesTable.dataSource = self
    }
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self

        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.text = defaults.string(forKey: "RecentSearch")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.hidesBackButton = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        moviesTable.frame = view.bounds
    }

}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: tableIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        viewModel.configureRows(indexPath: indexPath, cell: cell)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y, width: 100,
                                         height: header.bounds.height)
    }
}

extension MovieListViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        didTapDeleteKey = text.isEmpty
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !didTapDeleteKey && searchText.isEmpty {
                // Do something here
            guard let resultsController = searchController.searchResultsController as? SearchResultsViewController
            else {
                return
            }
            resultsController.movies = []
            resultsController.searchResultsCollectionView.reloadData()
        }

        didTapDeleteKey = false
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(self.reload(_:)),
                                               object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }

    @objc func reload(_ searchBar: UISearchBar) {
        viewModel.reload(self: self, searchBar: searchBar, searchController: searchController, defaults: defaults)
    }
    func updateSearchResults(for searchController: UISearchController) {
    }
    func searchResultsViewControllerDidTapItem(_ viewModel: MovieDetail) {
        DispatchQueue.main.async { [weak self] in
            let movieVC = MovieDetailViewController()
            movieVC.configure(with: viewModel)
            self?.navigationController?.pushViewController(movieVC, animated: true)
        }
    }

}
extension MovieListViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: TableViewCell, viewModel: MovieDetail) {
        DispatchQueue.main.async { [weak self] in
            let movieVC = MovieDetailViewController()
            movieVC.configure(with: viewModel)
            self?.navigationController?.pushViewController(movieVC, animated: true)
        }
    }
}
