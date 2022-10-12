//
//  SearchResultsViewController.swift
//  NetflixClone
//
//  Created by ekincare on 12/10/22.
//

import UIKit

class SearchResultsViewController: UIViewController {
    public var titles: [Title] = [Title]()
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-10, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let searchResultsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        searchResultsCollectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return searchResultsCollectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        view.addSubview(searchResultsCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    

}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchResultsCollectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
        print("Poster Url",titles[indexPath.row].poster_path ?? "URL not able to fetch")
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "/unWo9e3VrfnT6vfb3PKtzjvBfC7.jpg")
        return cell
    }
    
}
