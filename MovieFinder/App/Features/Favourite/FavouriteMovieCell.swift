//
//  FavouriteMovieCell.swift
//  YouMovies
//
//  Created by Indrapal Pratap on 18/06/25.
//

import UIKit

class FavouriteMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var onRemoveTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        removeButton.setImage(UIImage(systemName: SystemIcon.closeCircle), for: .normal)
        removeButton.tintColor = .white
        removeButton.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
    }
    
    @objc private func removeTapped() {
        onRemoveTapped?()
    }
    
    func configure(with movie: FavouriteMovieEntity) {
        titleLabel.text = movie.title
        if let path = movie.posterPath, let url = URL(string: "\(API.imageBaseURL)\(path)") {
            loadImage(from: url)
        } else {
            imageView.image = UIImage(named: AssetName.placeholder)
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
