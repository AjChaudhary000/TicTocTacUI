//
//  TicTocVC.swift
//  TIcTocUI
//
//  Created by Sam Chaudhari on 01/07/21.
//

import UIKit

class TicTocVC: UICollectionViewCell {
    private let myImageView:UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            return imageView
        }()
        
        func setupCell(with status:Int) {
            
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.lightGray.cgColor
            
            contentView.addSubview(myImageView)
            
            myImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            
            let name = status == 0 ? "o" : status == 1 ? "x" : ""
            
            myImageView.image = UIImage(named: name)
        }
        
}
