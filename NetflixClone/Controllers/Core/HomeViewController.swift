//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by ekincare on 07/10/22.
//

import UIKit

enum sections: Int {
    case TreandingMovie = 0
    case TreandingTv = 1
    case PopularMovie = 2
    case UpcommingMovie = 3
    case TopRatedMovie = 4
}

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    let sectionTitle: [String] = ["Treanding Movies","Popular","Treanding Tv","Upcoming Movies","Top rated"]
    let mainTableView: UITableView = {
        let mainTableView = UITableView()
        mainTableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return mainTableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.backgroundColor = .black
        
        view.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        configureNavbar()
        let tableHeader = HeroImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
        mainTableView.tableHeaderView = tableHeader
//        mainTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        APICaller.shared.getMovies(with: "Hello") { result in
            //
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTableView.frame = view.bounds
    }
    
    func configureNavbar(){
        var image = UIImage(named: "netflixLogo2")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
     
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as?  CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        switch indexPath.section{
        case sections.TreandingMovie.rawValue:
            APICaller.shared.getTreandingMovies { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sections.TreandingTv.rawValue:
            APICaller.shared.getTreandingTvs { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sections.PopularMovie.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sections.UpcommingMovie.rawValue:
            APICaller.shared.getUpcommingMovies { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case sections.TopRatedMovie.rawValue:
            APICaller.shared.getTopRated { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            UITableViewCell()
        }
 
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.textColor = .white
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffSet = view.safeAreaInsets.top
        let offSet = scrollView.contentOffset.y + defaultOffSet
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offSet))
    }
}
