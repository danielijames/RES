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
    
    var FacultyName = UILabel()
    var procedure = UILabel()
    var date = UILabel()
    var score = UILabel()
    var ClickME = UILabel()
    var card = UIView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        buildLabels()
    }
    
    fileprivate func addLabel(labelName: UILabel, topContraint: CGFloat) {
        labelName.font = .systemFont(ofSize: 24, weight: .semibold)
        labelName.textAlignment = .center
        labelName.textColor = .black
        self.contentView.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topContraint),
            labelName.widthAnchor.constraint(equalToConstant: 300),
            labelName.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0)
        ])
    }
    
    func buildLabels(){
//        card.backgroundColor = UIColor.placeholderText
        self.contentView.addSubview(card)

        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: card.topAnchor, constant: 0),
            self.contentView.widthAnchor.constraint(equalTo: card.widthAnchor, constant: 0),
        self.contentView.heightAnchor.constraint(equalTo: card.heightAnchor, constant: 0),
        ])
        
        FacultyName.font = .boldSystemFont(ofSize: 22)
        FacultyName.textAlignment = .center
        FacultyName.textColor = .black
        self.contentView.addSubview(FacultyName)
        FacultyName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        FacultyName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
        FacultyName.widthAnchor.constraint(equalToConstant: 300),
        FacultyName.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0)
        ])
        
        
        addLabel(labelName: procedure, topContraint: 80)
        addLabel(labelName: date, topContraint: 110)
        addLabel(labelName: score, topContraint: 140)
        addLabel(labelName: ClickME, topContraint: 220)
    }


}
