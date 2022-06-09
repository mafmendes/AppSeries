//
//  MovieDetailViewModel.swift
//  AppSeriesNew
//
//  Created by Mendes, Mafalda Joana on 03/06/2022.
//

import Foundation
import UIKit
import AlamofireImage
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
    func configureMovieDetail(
        model: MovieDetail,
        posterImageView: UIImageView,
        titleLabel: UILabel,
        descriptionLabel: UILabel,
        ratingLabel: UILabel,
        actorsLabel: UILabel) {
            // if url has this string, which will mean it will have bad quality
            if model.imageView.contains("m.media-amazon") {
            // So after this 2 caracthers
            if let index = (model.imageView.range(of: "UX")?.lowerBound) {
              let beforeEqualsTo = String(model.imageView.prefix(upTo: index))
              // replace it with this new string, which will give the image a high quality
              let newString = "SY1000_CR0,0,675,1000_AL_.jpg"
                var newModel = beforeEqualsTo
                newModel.append(newString)
                guard let url = URL(string: newModel) else {
                    return
                }
                posterImageView.sd_setImage(with: url, placeholderImage: nil)
            } else if let index = (model.imageView.range(of: "UY")?.lowerBound) {
              // comments above is the same for the following code
              let beforeEqualsTo = String(model.imageView.prefix(upTo: index))
              let newString = "SY1000_CR0,0,675,1000_AL_.jpg"
                var newModel = beforeEqualsTo
                newModel.append(newString)
                guard let url = URL(string: newModel) else {
                    return
                }

                posterImageView.sd_setImage(with: url, placeholderImage: nil)
            }
        } else {
            guard let url = URL(string: model.imageView) else {
                return
            }
            posterImageView.sd_setImage(with: url, placeholderImage: nil)
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

extension MovieDetailViewController {
    @objc func popupAlert(_ sender: UIButton!) {
            let alert = UIAlertController(title: "Do you want to download this movie",
                                        message: "",
                                        preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
                }))
            var rootViewController = UIApplication.shared.keyWindow?.rootViewController
            if let navigationController = rootViewController as? UINavigationController {
                rootViewController = navigationController.viewControllers.first
            }
            rootViewController?.present(alert, animated: true, completion: nil)
        }
}
