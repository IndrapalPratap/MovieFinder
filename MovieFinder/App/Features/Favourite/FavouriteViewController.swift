//
//  FavouriteViewController.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 21/06/25.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var favourites: [FavouriteMovieEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        cellRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavourites()
    }
    
    func cellRegister() {
        
        collectionView.register(UINib(nibName: "FavouriteMovieCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteMovieCell")
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let totalSpacing = spacing * 3
        let itemWidth = (view.frame.width - totalSpacing) / 2
        
        layout.itemSize = CGSize(width: itemWidth, height: 264)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        collectionView.collectionViewLayout = layout
    }
    
    private func loadFavourites() {
        favourites = CoreDataManager.shared.fetchFavourites()
        collectionView.reloadData()
    }
}

extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteMovieCell", for: indexPath) as? FavouriteMovieCell else {
            return UICollectionViewCell()
        }
        
        let fav = favourites[indexPath.row]
        cell.configure(with: fav)
        
        cell.onRemoveTapped = { [weak self] in
            guard let self = self else { return }
            let movieId = Int(fav.id)
            CoreDataManager.shared.delete(movieId: movieId)
            self.favourites.remove(at: indexPath.row)
            self.collectionView.deleteItems(at: [indexPath])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fav = favourites[indexPath.row]
        let model = MoviesModel(
            id: Int(fav.id),
            title: fav.title ?? "",
            overview: fav.overview ?? "No description available",
            posterPath: fav.posterPath,
            releaseDate: fav.releaseDate ?? "Unknown",
            voteAverage: fav.voteAverage
        )
        
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            detailVC.movie = model
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
