//
//  HomeTableViewCell.swift
//  YouMovies
//
//  Created by Indrapal Pratap on 17/06/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeRatingLabel: UILabel!
    @IBOutlet weak var homeReleaseDateLabel: UILabel!
    @IBOutlet weak var homeTitleLabel: UILabel!
    @IBOutlet weak var homeBannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
        homeBannerImageView.contentMode = .scaleAspectFill
        homeBannerImageView.clipsToBounds = true
        homeBannerImageView.layer.cornerRadius = 8
        homeBannerImageView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }
    
    func setupUI() {
        
        homeTitleLabel.applyHeadingStyle()
        homeReleaseDateLabel.applySubheadingStyle()
        homeRatingLabel.applyRatingStyle()
        
    }
    
    func configure(with movie: MoviesModel) {
        homeTitleLabel.text = movie.title
        homeReleaseDateLabel.text = "\(LabelText.releasePrefix)\(movie.releaseDate ?? LabelText.notAvailable)"
        if let rating = movie.voteAverage {
            homeRatingLabel.text = "\(Symbol.star)\(String(format: "%.1f", rating))"
        } else {
            homeRatingLabel.text = "\(Symbol.star)\(LabelText.notAvailable)"
        }
        
        if let path = movie.posterPath,
           let url = URL(string: "\(API.imageBaseURL)\(path)") {
            loadImage(from: url)
        } else {
            homeBannerImageView.image = UIImage(named: AssetName.placeholder)
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.homeBannerImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
