//
//  TopSearchViewController.swift
//  NetflixClone
//
//  Created by ekincare on 07/10/22.
//

import UIKit

class TopSearchViewController: UIViewController, UISearchControllerDelegate {
  
    

    public var titles: [Title] = [Title]()
    
    let discoverTable: UITableView = {
        let discoverTable = UITableView()
        discoverTable.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return discoverTable
    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultsViewController())
        searchController.searchBar.placeholder = "Search for a mobile or a tv show"
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    
        discoverTable.delegate = self
        discoverTable.dataSource = self
        view.addSubview(discoverTable)
        navigationItem.searchController = searchController
//        navigationController?.navigationBar.tintColor = .white
        searchController.searchResultsUpdater = self
       
        fetchDiscover()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func fetchDiscover(){
        APICaller.shared.getMoviesDiscover { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
extension TopSearchViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = discoverTable.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: (title.original_name ?? title.original_title) ?? "Unknown", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
  
}

extension TopSearchViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {return}
        
        
              APICaller.shared.search(with: query) { result in
                  DispatchQueue.main.async{
                 switch result{
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                   
                case .failure(let error):
                    print("Hello",error.localizedDescription)
                }
            }
        }
    }
}

