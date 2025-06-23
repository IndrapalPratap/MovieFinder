//
//  SearchViewController.swift
//  MovieFinder
//
//  Created by Indrapal Pratap on 20/06/25.
//
import UIKit


class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var debounceTimer: Timer?
       let viewModel = MovieSearchViewModel()
       private var loader: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)

       private let emptyStateLabel: UILabel = {
           let label = UILabel()
           label.text = EmptyStateText.noResults
           label.textAlignment = .center
           label.textColor = .lightGray
           label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
           label.isHidden = true
           return label
       }()

       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
           cofigureUI()
           cellRegister()
           enableKeyboardDismissOnTap()
       }

       func cellRegister() {
           tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil),
                              forCellReuseIdentifier: "SearchResultTableViewCell")
       }

       private func setupUI() {
           searchBar.delegate = self
           configureSearchBar()

           tableView.delegate = self
           tableView.dataSource = self
           tableView.rowHeight = 120

           loader.center = view.center
           loader.hidesWhenStopped = true
           loader.color = .lightGray
           view.addSubview(loader)

           emptyStateLabel.frame = view.bounds
           view.addSubview(emptyStateLabel)
       }

       private func configureSearchBar() {
           searchBar.searchBarStyle = .minimal
           searchBar.backgroundColor = .white
           searchBar.layer.cornerRadius = 12
           searchBar.layer.masksToBounds = true
           searchBar.placeholder = PlaceholderText.searchMovieName

           if let textField = searchBar.value(forKey: "searchField") as? UITextField {
               textField.backgroundColor = .clear
               textField.borderStyle = .none
               textField.layer.backgroundColor = UIColor.clear.cgColor
               textField.clearButtonMode = .whileEditing
           }
       }

       private func cofigureUI() {
           viewModel.onUpdate = { [weak self] in
               DispatchQueue.main.async {
                   guard let self = self else { return }
                   self.loader.stopAnimating()
                   self.tableView.reloadData()
                   self.emptyStateLabel.isHidden = self.viewModel.movies.count > 0
               }
           }

           viewModel.onError = { [weak self] message in
               DispatchQueue.main.async {
                   guard let self = self else { return }
                   self.loader.stopAnimating()
                   self.showAlert(title: AlertText.errorTitle, message: message)
               }
           }
       }

       private func search(for query: String) {
           guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }

           searchBar.resignFirstResponder()
           loader.startAnimating()
           emptyStateLabel.isHidden = true

           DispatchQueue.global(qos: .userInitiated).async {
               self.viewModel.search(query: query)
           }
       }

       private func clearResults() {
           searchBar.text = ""
           searchBar.resignFirstResponder()
           tableView.reloadData()
           emptyStateLabel.isHidden = true
       }

       private func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: AlertText.okButton, style: .default))
           present(alert, animated: true)
       }
   }

   // MARK: - UISearchBarDelegate
   extension SearchViewController: UISearchBarDelegate {

       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           debounceTimer?.invalidate()

           if searchText.isEmpty {
               clearResults()
               return
           }

           debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
               self?.search(for: searchText)
           }
       }

       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           debounceTimer?.invalidate()
           search(for: searchBar.text ?? "")
           searchBar.resignFirstResponder()
       }

       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           clearResults()
       }
   }

   // MARK: - UITableViewDataSource & Delegate
   extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return viewModel.movies.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell else {
               return UITableViewCell()
           }

           let movie = viewModel.movie(at: indexPath.row)
           cell.configure(with: movie)
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedMovie = viewModel.movie(at: indexPath.row)
           let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
           if let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
               detailVC.movie = selectedMovie
               navigationItem.backButtonTitle = ""
               navigationController?.pushViewController(detailVC, animated: true)
           }
       }
   }

