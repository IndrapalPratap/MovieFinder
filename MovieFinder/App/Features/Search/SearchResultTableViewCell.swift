//
//  SearchResultTableViewCell.swift
//  YouMovies
//
//  Created by Indrapal Pratap on 17/06/25.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var moviewBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        moviewBanner.contentMode = .scaleAspectFill
        moviewBanner.clipsToBounds = true
        moviewBanner.layer.cornerRadius = 6
        
        searchResultLabel.font = UIFont.boldSystemFont(ofSize: 18)
        searchResultLabel.textColor = .white
        
        releaseYear.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        releaseYear.textColor = .gray
    }
    
    func configure(with model: MoviesModel) {
        searchResultLabel.text = model.title
        releaseYear.text = model.releaseDate?.prefix(4).description ?? PlaceholderText.notAvailable
        
        moviewBanner.image = UIImage(named: AssetName.defaultPoster) // Show placeholder first
        
        if let posterPath = model.posterPath,
           let url = URL(string: "\(API.imageBaseSmallURL)\(posterPath)") {
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else { return }
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self.moviewBanner.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
