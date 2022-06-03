//
//  CollectionViewCell.swift
//  APPSeriesNew
//
//  Created by Mendes, Mafalda Joana on 11/05/2022.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        posterImageView.image = nil
    }
    public func configure(with model: String) {
        if model.contains("m.media-amazon") {
            if let index = (model.range(of: "UX")?.lowerBound) {
              let beforeEqualsTo = String(model.prefix(upTo: index))
              let newString = "SY1000_CR0,0,675,1000_AL_.jpg"
              var newModel = beforeEqualsTo
              newModel.append(newString)
              guard let url = URL(string: newModel) else {
                    return
                }
                posterImageView.af.setImage(withURL: url, placeholderImage: UIImage(systemName: "goforward"))
            } else if let index = (model.range(of: "UY")?.lowerBound) {
              let beforeEqualsTo = String(model.prefix(upTo: index))
                let newString = "SY1000_CR0,0,675,1000_AL_.jpg"
                var newModel = beforeEqualsTo
                newModel.append(newString)
                guard let url = URL(string: newModel) else {
                    return
                }
                posterImageView.af.setImage(withURL: url, placeholderImage: UIImage(systemName: "goforward"))
            }
        } else {
            guard let url = URL(string: model) else {
                return
            }
            posterImageView.af.setImage(withURL: url, placeholderImage: UIImage(systemName: "goforward"))
        }
    }
}
