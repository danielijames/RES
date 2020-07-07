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
    func magnifyCell(with EvaluationDate: String)
    func getData() -> [gradingCritereon]?
}


class GraphView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    let TotalLabel = UILabel()
    let AnimateView = UIView()
    let layout = UICollectionViewFlowLayout()
    var collection: UICollectionView!
    let bgWhiteview = UIView()
    
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

        TotalLabel.font = .boldSystemFont(ofSize: 24)
        TotalLabel.lineBreakMode = .byWordWrapping
        TotalLabel.numberOfLines = 2
        TotalLabel.textAlignment = .left
        
        bgWhiteview.frame = .init(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        bgWhiteview.backgroundColor = .white
        super.addSubview(bgWhiteview)
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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

        layout.itemSize = .init(width: ScreenSize.width-100, height: 350)
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 20, bottom: 20, right: 20)
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundView = view
        collection.clipsToBounds = true
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
        return self.delegate?.getData()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellView.identifier, for: indexPath) as! CellView
        
        if let cellData = self.delegate?.getData() {
            cell.date.text = cellData[indexPath.row].date
            cell.procedure.text = cellData[indexPath.row].procedure
            cell.FacultyName.text = cellData[indexPath.row].FacultyName
            cell.score.text = "Score: " + (cellData[indexPath.row].score?.first?.description ?? "No Score Provided")
            beautifyCell(cell: cell)
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        perform segue to larger controller with more information
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.allowsSelection = true

        if let cellData = self.delegate?.getData() {
            let date = cellData[indexPath.row].date!
            self.delegate?.magnifyCell(with: date)
        }
    }
    
    func beautifyCell(cell: CellView){
        cell.ClickME.text = "See Graded Evaluation"
        cell.layer.cornerRadius = 17.5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 5
        cell.ClickME.font = .boldSystemFont(ofSize: 24)
        cell.ClickME.textColor = .white
        
        switch cell.score.text {
        case "Score: 1":
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case "Score: 2":
            cell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case "Score: 3":
            cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        default:
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }
        
        
        cell.isUserInteractionEnabled = true
    }
    
    

}
