//
//  VariadicView.swift
//  RES
//
//  Created by Daniel James on 4/9/20.
//  Copyright © 2020 CUIP. All rights reserved.
//

import UIKit

protocol ViewDelegate: AnyObject {
    func continueToNextScreen(indexPath: IndexPath)
    func getTitle() -> String!
    func getContentArray() -> Array<String>
}

class VariadicView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: ViewDelegate?
    let table = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createTableView()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)
        createTableView()
    }
    
    func createTableView(){
        let button = UIButton()
        button.layer.cornerRadius = 17.5
        button.backgroundColor = .systemGreen
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
  
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        table.contentInset.top = 45
        table.contentInset.bottom = -50
        
        super.addSubview(table)
        super.addSubview(button)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.widthAnchor.constraint(equalToConstant: ScreenSize.width).isActive = true
        table.heightAnchor.constraint(equalToConstant: ScreenSize.height).isActive = true
        table.centerXAnchor.constraint(equalTo: super.centerXAnchor).isActive = true
        table.centerYAnchor.constraint(equalTo: super.centerYAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 175).isActive = true
        button.centerXAnchor.constraint(equalTo: super.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 58).isActive = true
        button.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -ScreenSize.height*0.05).isActive = true
    }
    
    @objc func buttonAction(){
//        self.delegate?.continueToNextScreen()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getContentArray().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return delegate?.getTitle()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = delegate?.getContentArray()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.continueToNextScreen(indexPath: indexPath)
    }
    
    
}
