//
//  CustomTableViewCell.swift
//  BookMarkCollector
//
//  Created by Yerkebulan Sharipov on 01.03.2022.
//

import Foundation
import UIKit

class CustomTableViewCell : UITableViewCell {
    
    lazy var Vector : UIButton = {
       let Vector = UIButton()
        Vector.setImage(UIImage(named: "Group"), for: .normal)
        Vector.translatesAutoresizingMaskIntoConstraints = false
        Vector.addAction(.init(handler: {_ in
            self.OpenBrowser()
            
        }), for: .touchUpInside)
        
    
        return Vector
    }()
    
    lazy var  nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var  linkLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        self.contentView.addSubview(Vector)
        self.addSubview(nameLabel)
        
        let constraints = [ Vector.widthAnchor.constraint(equalToConstant: 18),
                            Vector.heightAnchor.constraint(equalToConstant: 18),
                            Vector.rightAnchor.constraint(equalTo: super.rightAnchor, constant: -19),
                            Vector.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -14),
                            
                            nameLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 16),
                            nameLabel.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -11)
                        
            ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(name: LinkModel){
        nameLabel.text = name.title
        linkLabel.text = name.link
      
    }
    // -MARK: function that opens Browser
    
    private func OpenBrowser(){
        guard let url = URL(string: "https://\(linkLabel.text!)") else{ return }
        UIApplication.shared.open(url)
       
    }
}
