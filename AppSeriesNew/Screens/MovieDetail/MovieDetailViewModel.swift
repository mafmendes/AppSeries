//
//  MovieDetailViewModel.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 03/06/2022.
//

import Foundation
import UIKit
#warning("too much logic for one place only. mvvm problens")
class MovieDetailViewModel {
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                     attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    #warning("Mudar os parametros desta função para 2 -> Model e Array")
    func configureMovieDetail(
        model: MovieDetail,
        posterImageView: UIImageView,
        titleLabel: UILabel,
        descriptionLabel: UILabel,
        ratingLabel: UILabel,
        actorsLabel: UILabel) {
        if model.imageView.contains("m.media-amazon") {
            if let index = (model.imageView.range(of: "UX")?.lowerBound) {
              let beforeEqualsTo = String(model.imageView.prefix(upTo: index))
              let newString = "SY1000_CR0,0,675,1000_AL_.jpg"
                var newModel = beforeEqualsTo
                newModel.append(newString)
                guard let url = URL(string: newModel) else {
                    return
                }

                posterImageView.af.setImage(withURL: url, placeholderImage: UIImage(systemName: "goforward"))
            } else if let index = (model.imageView.range(of: "UY")?.lowerBound) {
              let beforeEqualsTo = String(model.imageView.prefix(upTo: index))
              let newString = "SY1000_CR0,0,675,1000_AL_.jpg"
                var newModel = beforeEqualsTo
                newModel.append(newString)
                guard let url = URL(string: newModel) else {
                    return
                }

                posterImageView.af.setImage(withURL: url, placeholderImage: UIImage(systemName: "goforward"))
            }
        } else {
            guard let url = URL(string: model.imageView) else {
                return
            }
            posterImageView.af.setImage(withURL: url, placeholderImage: UIImage(systemName: "goforward"))
        }
        titleLabel.text = model.fullTitle
        if model.imDbRating.isEmpty && model.metacriticRating.isEmpty {
        } else {
            if model.imDbRating.isEmpty {
                ratingLabel.attributedText = attributedText(
                    withString: String(format: "Metacritic Rating: " + model.metacriticRating),
                    boldString: "Metacritic Rating:", font: ratingLabel.font)
            } else if model.metacriticRating.isEmpty {
                ratingLabel.attributedText = attributedText(
                    withString: String(format: "imDB Rating: " + model.imDbRating),
                    boldString: "imDB Rating:", font: ratingLabel.font)
            }
        }
        if !model.actors.isEmpty {
            actorsLabel.attributedText = attributedText(
                withString: String(format: "Crew: " + model.actors),
                boldString: "Crew:", font: actorsLabel.font)
        }
        if !model.description.isEmpty {
            descriptionLabel.attributedText = attributedText(
                withString: String(format: "Description: " + model.description),
                boldString: "Description:", font: descriptionLabel.font)
        }
    }
}
