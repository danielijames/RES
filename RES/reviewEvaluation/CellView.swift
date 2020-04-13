//
//  CellView.swift
//  RES
//
//  Created by Daniel James on 4/12/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit

class CellView: UICollectionViewCell {
    
    static var identifier: String = "cell"
    
    var DateTitleLabel = UILabel()
    var procedure = UILabel()
    var card = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        buildLabels()
    }
    
    func buildLabels(){
        card.backgroundColor = UIColor.placeholderText
//        card.layer.cornerRadius = 12.5
//        card.layer.borderWidth = 3
//        card.layer.borderColor = UIColor.black.cgColor
        
        self.contentView.addSubview(card)

        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: card.topAnchor, constant: 0),
            self.contentView.widthAnchor.constraint(equalTo: card.widthAnchor, constant: 0),
        self.contentView.heightAnchor.constraint(equalTo: card.heightAnchor, constant: 0),
        ])
        
        DateTitleLabel.font = .boldSystemFont(ofSize: 22)
        DateTitleLabel.textAlignment = .center
        DateTitleLabel.textColor = .black
        self.contentView.addSubview(DateTitleLabel)
        DateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        DateTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
        DateTitleLabel.widthAnchor.constraint(equalToConstant: 300),
        DateTitleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0)
        ])
        
        
        
        procedure.font = .systemFont(ofSize: 24, weight: .semibold)
        procedure.textAlignment = .center
        procedure.textColor = .black
        self.contentView.addSubview(procedure)
        procedure.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        procedure.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
        procedure.widthAnchor.constraint(equalToConstant: 300),
        procedure.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0)
        ])

        
    }


}
