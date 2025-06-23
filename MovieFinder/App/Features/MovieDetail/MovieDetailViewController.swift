//
//  MovieDetailViewController.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 21/06/25.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    
    var movie: MoviesModel!
    private var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieDetailViewModel(movie: movie)
        setupUI()
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateHeartIcon()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func setupUI() {
        titleLabel.text = viewModel.getTitle()
        releaseDateLabel.text = "\(LabelText.releaseDatePrefix)\(viewModel.getReleaseDate())"
        descriptionLabel.text = viewModel.getOverview()
        ratingLabel.text = "\(LabelText.ratingPrefix)\(viewModel.getVoteAverage())"
        
        if let posterURL = viewModel.getPosterURL() {
            loadImage(from: posterURL)
        } else {
            bannerImageView.image = UIImage(named: AssetName.defaultPoster)
        }
        
        heartButton.setTitle("", for: .normal) // remove any default title
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data else { return }
            DispatchQueue.main.async {
                self.bannerImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    @IBAction func heartTapped(_ sender: UIButton) {
        if CoreDataManager.shared.isFavourite(movieId: movie.id) {
            CoreDataManager.shared.delete(movieId: movie.id)
        } else {
            CoreDataManager.shared.save(movie: movie)
        }
        updateHeartIcon()
    }
    
    private func updateHeartIcon() {
        guard let movie = movie else { return }
        let isLiked = CoreDataManager.shared.isFavourite(movieId: movie.id)
        
        let config = UIImage.SymbolConfiguration(pointSize: 21, weight: .semibold)
        let imageName = isLiked ? "heart.fill" : "heart"
        let icon = UIImage(systemName: imageName, withConfiguration: config)
        
        heartButton.setImage(icon, for: .normal)
        heartButton.tintColor = isLiked ? .systemRed : .white
    }
}
