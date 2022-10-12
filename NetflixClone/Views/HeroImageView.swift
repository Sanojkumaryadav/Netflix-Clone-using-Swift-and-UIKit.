//
//  HeroImageView.swift
//  NetflixClone
//
//  Created by ekincare on 07/10/22.
//

import UIKit

class HeroImageView: UIView {
    
    let gradientLayer = CAGradientLayer()
    
    let playButton: UIButton = {
        let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = 1
        playButton.layer.cornerRadius = 5
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    let downloadButton: UIButton = {
        let downloadButton = UIButton()
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.layer.borderColor = UIColor.white.cgColor
        downloadButton.layer.borderWidth = 1
        downloadButton.layer.cornerRadius = 5
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        return downloadButton
    }()
    
    var heroImage: UIImageView = {
        let heroImage = UIImageView()
        heroImage.contentMode = .scaleAspectFill
        heroImage.clipsToBounds = true
        heroImage.image = UIImage(named: "img")
        return heroImage
    }()

    
    func addGradient(){
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImage)
//        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraint()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImage.frame = bounds
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyConstraint(){
        
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        
        let downloadButtonConstraint = [
            downloadButton.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor,constant: -70),
            downloadButton.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(downloadButtonConstraint)
        
      
        
    
    }

    
}
