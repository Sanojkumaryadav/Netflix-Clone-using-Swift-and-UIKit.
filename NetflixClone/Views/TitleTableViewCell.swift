//
//  TitleTableViewCell.swift
//  NetflixClone
//
//  Created by ekincare on 11/10/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

   static let identifier = "TitleTableViewCell"
  
    let titlePoster: UIImageView = {
        let titlePoster = UIImageView()
        titlePoster.translatesAutoresizingMaskIntoConstraints = false
        titlePoster.clipsToBounds = true
        return titlePoster
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let titlePlayBotton: UIButton = {
        let titlePlayBotton = UIButton()
        let image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30 ))
        titlePlayBotton.setImage(image, for: .normal)
//        titlePlayBotton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        titlePlayBotton.translatesAutoresizingMaskIntoConstraints = false
        return titlePlayBotton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePoster)
        contentView.addSubview(titleLabel)
       

        contentView.addSubview(titlePlayBotton)
        applyConstraints()
        
    }
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else{return}
        let data = try? Data(contentsOf: url)
        titlePoster.image = UIImage(data: data!)
        titleLabel.text = model.titleName
//        print(titleLabel.text)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        titlePoster.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
//        titleLabel.frame =  CGRect(x: 170, y: 0, width: 150, height: 150)
//    }
    
    func applyConstraints(){
        let titlePosterConstraints = [
            self.titlePoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            self.titlePoster.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            self.titlePoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            self.titlePoster.widthAnchor.constraint(equalToConstant: 100)
        ]

        let titleLabelConstraints = [
            self.titleLabel.leadingAnchor.constraint(equalTo: titlePoster.trailingAnchor, constant: 40),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 180),
            self.titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]

        let titlePlayBottonConstraints = [
            self.titlePlayBotton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -40),
            self.titlePlayBotton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlePosterConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(titlePlayBottonConstraints)
    }
  

}
