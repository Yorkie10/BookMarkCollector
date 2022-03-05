//
//  SecondScreen.swift
//  BookMarkCollector
//
//  Created by Yerkebulan Sharipov on 22.02.2022.
//

import Foundation
import UIKit

class SecondScreen : UIViewController {
    
    lazy var links : [LinkModel]  = Storage.linkModels
     
    // -MARK: Creating all views down here
    
    lazy var topText : UILabel = {
        topText = UILabel()
        topText.text = "Bookmark App"
        topText.textColor = .black
        topText.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return topText
    }()
    
    // this text will be shown with TableView(List)
    
    lazy var PageName : UILabel = {
        PageName = UILabel()
        PageName.text = "List"
        PageName.textColor = .black
        PageName.font = .systemFont(ofSize: 17, weight: .semibold)
        return PageName
    }()
    
    lazy var mainText : UILabel = {
        mainText = UILabel()
        mainText.text = "Save your first \nbookmark"
        mainText.textColor = .black
        mainText.font = .systemFont(ofSize: 36, weight: .bold)
        mainText.textAlignment = .center
        mainText.numberOfLines = 2
        return mainText
    }()
    
    // Button which adds Links on the tableview
    
    lazy var btn : UIButton = {
        btn = UIButton()
        btn.setTitle("Add bokmark", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 16
        btn.addAction( .init(handler: {_ in
            
            self.showAlert()} ), for: .touchUpInside)
        
        return btn
    } ()
    
    // creating TableView
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
   
        return tableView
    }()
    
    
    
    
    // -MARK: function which adds Links to Array
    
    private func addLinkToArray(title: String, link: String){
        
        self.links.append(LinkModel(title: title, link: link))
        Storage.linkModels.append(LinkModel(title: title, link: link))
        self.tableView.reloadData()
        checkLinks()
    
    }
    
    // -MARK: this function is checking if the Array of links is empty and changing page labels
    
    private func checkLinks() {
        if links.isEmpty {
            
            tableView.isHidden = true
            topText.isHidden = false
            PageName.isHidden = true
            
        } else {
            
            tableView.isHidden = false
            topText.isHidden = true
            PageName.isHidden = false
        }
    }
    
    
    //-MARK: Alert
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Change", message: "Links",   preferredStyle: .alert)
        let action = UIAlertAction(title: "Save", style: .default) {_ in
            
            guard let title = alertController.textFields?[0].text, title != "" else {return}
            guard let link = alertController.textFields?[1].text, link != "" else {return}
            self.addLinkToArray(title: title, link: link)
            
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Bookmark title"
            
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Bookmark link"
            
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
                                               
        }))
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLinks()
        self.view.backgroundColor = .white
       
        [ topText, mainText, btn, tableView, PageName].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        tableView.delegate = self   // these two for realizing extension with Protocols
        tableView.dataSource = self
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Links")
        view.addSubview(topText)
        view.addSubview(PageName)
        view.addSubview(mainText)
        view.addSubview(btn)
        view.addSubview(tableView)
        
        // -MARK: Constraints for all views
        
        let constraints = [topText.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
                           topText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                           
                           PageName.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
                           PageName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                           
                           
                           tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 119),
                           tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
                           tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                           tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                           
                           mainText.widthAnchor.constraint(equalToConstant: 358),
                           mainText.heightAnchor.constraint(equalToConstant: 92),
                           
                           mainText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                           mainText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                           mainText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                           mainText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
                           
                           btn.widthAnchor.constraint(equalToConstant: 358),
                           btn.heightAnchor.constraint(equalToConstant: 52),
                           
                           btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
                           btn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                           btn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// -MARK: Extenension for using methods to work with tableView

extension SecondScreen : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Links", for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        cell.configure(name: links[indexPath.row])
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            links.remove(at: indexPath.row)
            Storage.linkModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            checkLinks()
        }
    }
}
