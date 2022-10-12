//
//  UpcomingViewController.swift
//  NetflixClone
//
//  Created by ekincare on 07/10/22.
//

import UIKit

class UpcomingViewController: UIViewController {

    public var titles: [Title] = [Title]()
    let upcomingMovie: UITableView = {
        let upcomingMovie = UITableView()
        upcomingMovie.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return upcomingMovie
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcomming"
        view.backgroundColor = .systemBlue
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        upcomingMovie.delegate = self
        upcomingMovie.dataSource = self
        view.addSubview(upcomingMovie)
        fetchUpcomming()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingMovie.frame = view.bounds
    }
    
    func fetchUpcomming(){
        APICaller.shared.getUpcommingMovies { [weak self] result in
            switch result{
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingMovie.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

extension UpcomingViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = upcomingMovie.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else{
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unknown", posterURL: title.poster_path ?? ""))
//        cell.titleLabel.text = (title.original_title ?? title.original_name) ?? "Unknown"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
