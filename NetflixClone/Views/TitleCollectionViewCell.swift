//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by ekincare on 11/10/22.
//

import UIKit


class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    let posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFill
        return posterImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configure(with model: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {return}
        let data = try? Data(contentsOf: url)
        posterImageView.image = UIImage(data: data!)
    }
    
}
