//
//  GraphView.swift
//  RES
//
//  Created by Daniel James on 4/12/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit

extension CGFloat {
    var degreesToRadians: Self {
        return self * .pi/180
    }
}

protocol GraphViewDelegate: AnyObject {
    func Count() -> (Sent: CGFloat, Graded: CGFloat)?
}


class GraphView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    let TotalLabel = UILabel()
    let AnimateView = UIView()
    
    var collection: UICollectionView!
    
    weak var delegate: GraphViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        bgView()
        collectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bgView()
        collectionView()
    }
    
    func bgView(){
        
        let view = UIView()
        
        TotalLabel.font = .boldSystemFont(ofSize: 24)
        TotalLabel.lineBreakMode = .byWordWrapping
        TotalLabel.numberOfLines = 2
        TotalLabel.textAlignment = .left
        
        view.frame = .init(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        view.backgroundColor = .white
        super.addSubview(view)
        
        super.addSubview(AnimateView)
        super.addSubview(TotalLabel)
        
        AnimateView.translatesAutoresizingMaskIntoConstraints = false
        AnimateView.centerXAnchor.constraint(equalTo: super.centerXAnchor, constant: 0).isActive = true
        AnimateView.centerYAnchor.constraint(equalTo: super.centerYAnchor, constant: -200).isActive = true
        AnimateView.widthAnchor.constraint(equalToConstant: ScreenSize.width).isActive = true
        AnimateView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        TotalLabel.translatesAutoresizingMaskIntoConstraints = false
        TotalLabel.topAnchor.constraint(equalTo: AnimateView.centerYAnchor, constant: -30).isActive = true
        TotalLabel.centerXAnchor.constraint(equalTo: super.centerXAnchor, constant: 0).isActive = true
        TotalLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        TotalLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        TotalLabel.text = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
        self.AnimatableCircle(strokeEnd: 1.0, fillColor: UIColor.clear.cgColor, strokeColor: UIColor.systemGreen.cgColor)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            
            if let (Sent, Graded) = (self.delegate?.Count()) {
                
                let ratio = Graded/Sent
            
                self.AnimatableCircle(strokeEnd: CGFloat(ratio), fillColor: UIColor.clear.cgColor, strokeColor: UIColor.systemBlue.cgColor)
                
            }
          }
        }
    
    
    fileprivate func AnimatableCircle(strokeEnd: CGFloat, fillColor: CGColor, strokeColor: CGColor) {
        var circleLayer = CAShapeLayer()
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: AnimateView.bounds.width*0.5, y: AnimateView.bounds.height*0.5), radius: 140, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = fillColor
        circleLayer.strokeColor = strokeColor
        circleLayer.lineWidth = 20.0;
        //wait for animation to draw
        circleLayer.strokeEnd = 0.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2.5
        animation.fromValue = 0
        animation.toValue = strokeEnd
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        circleLayer.strokeEnd = strokeEnd
        
        circleLayer.add(animation, forKey: "animateCircle")
        
        AnimateView.layer.addSublayer(circleLayer)
    }
    
    
    
    func collectionView(){
        let view = CellView()
        
        view.frame = .init(x: 0, y: ScreenSize.height*0.5, width: ScreenSize.width, height: ScreenSize.height*0.5)
        view.backgroundColor = .white

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: ScreenSize.width-100, height: 350)
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 20, bottom: 20, right: 20)
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        

        
        collection.backgroundView = view
        collection.register(CellView.self, forCellWithReuseIdentifier: CellView.identifier)
        collection.delegate = self
        collection.dataSource = self

        super.addSubview(collection)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collection.widthAnchor.constraint(equalToConstant: ScreenSize.width),
            collection.heightAnchor.constraint(equalToConstant: 400),
            collection.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: 0)
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellView.identifier, for: indexPath) as! CellView
        cell.DateTitleLabel.text = "04-28-2020 16:28"
        cell.procedure.text = "Laparascopic"
//        cell.card.backgroundColor = .darkGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //perform segue to larger controller with more information
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 5
        cell?.layer.borderColor = UIColor.black.cgColor
    }



}
