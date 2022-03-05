//
//  ViewController.swift
//  BookMarkCollector
//
//  Created by Yerkebulan Sharipov on 21.02.2022.
//

import UIKit

class ViewController: UIViewController {

    lazy var img : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Wall")
        img.contentMode = .scaleToFill

        return img
    }()
    
    lazy var txt : UILabel = {
        let txt = UILabel()
        txt.text = "Save all intersting links in one app"
        
        txt.font = .systemFont(ofSize: 36, weight: .bold)
        
        txt.textColor = .white
        txt.textAlignment = .left
        txt.numberOfLines = 2
        
        return txt
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Lets start collecting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.addAction(.init(handler: {_ in
          
            self.buttonDidPress()
            
            
        }), for: .touchUpInside)
        
        
        return button
    }()
    
 private func buttonDidPress(){
      
     
                 // обертка пунктирная линяя
        let vc = UINavigationController(rootViewController: SecondScreen())
     
   //  let vc = SecondScreen()

        vc.modalPresentationStyle = .fullScreen

         navigationController?.present(vc, animated: true)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        [ txt, img,  button].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false

        }
        
        
        view.addSubview(img)
  
        view.addSubview(button)

        view.addSubview(txt)
        
            
        let constraints = [
        
                           img.topAnchor.constraint(equalTo:  view.topAnchor),
                           img.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           img.leftAnchor.constraint(equalTo: view.leftAnchor),
                           img.rightAnchor.constraint(equalTo: view.rightAnchor),
                          
            
                           button.widthAnchor.constraint(equalToConstant: 358),
                           button.heightAnchor.constraint(equalToConstant: 52),
                         
                           button.bottomAnchor.constraint(equalTo: img.bottomAnchor, constant: -50),
                           button.leftAnchor.constraint(equalTo: img.leftAnchor, constant: 16),
                           button.rightAnchor.constraint(equalTo: img.rightAnchor, constant: -16),
                           
                           txt.widthAnchor.constraint(equalToConstant: 358),
                           txt.heightAnchor.constraint(equalToConstant: 92),
                         
                        
                           txt.leadingAnchor.constraint(equalTo: img.leadingAnchor, constant: 16),
                           txt.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24)
                           
                           
                     
                           ]
                    
      NSLayoutConstraint.activate(constraints)
        
       
    }

}

