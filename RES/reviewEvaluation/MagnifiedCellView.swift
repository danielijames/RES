//
//  MagnifiedCellView.swift
//  RES
//
//  Created by Daniel James on 4/19/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit

class MagnifiedCellView: UIView {
    let infoLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        giveGradeInfo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        giveGradeInfo()
    }
    
    
    func giveGradeInfo(){
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.frame = .init(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        
        let scrollView = UIScrollView()
        scrollView.frame = .init(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        scrollView.contentSize = .init(width: ScreenSize.width, height: 800)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        scrollView.addSubview(infoLabel)
        
        
        infoLabel.font = .boldSystemFont(ofSize: 18)
        infoLabel.textColor = .black
        infoLabel.contentMode = .center
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.numberOfLines = 0
        
        
//        scrollView.addSubview(infoLabel)
        scrollView.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        

        
        
        super.addSubview(bgView)
        super.addSubview(scrollView)
//        super.addSubview(infoLabel)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: ScreenSize.width),
            scrollView.topAnchor.constraint(equalTo: super.topAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: ScreenSize.height)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.widthAnchor.constraint(equalToConstant: ScreenSize.width-50),
            infoLabel.centerXAnchor.constraint(equalTo: super.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 800)
        ])
    }

}
