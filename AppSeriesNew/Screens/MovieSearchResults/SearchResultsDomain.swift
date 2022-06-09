//
//  SearchResultsDomain.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 03/06/2022.
//

import Foundation
import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: MovieDetail)
}

enum SearchResultsSizes {
    static var collectionViewWidth: CGFloat { 100 }
    static var collectionViewHeight: CGFloat { 200 }
}
