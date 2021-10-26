//
//  CharactersViewController.swift
//  HogwartsApp
//
//  Created by William Henrique Gonçalves Ribeiro on 03/10/21.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var viewMain: GradientView!
    @IBOutlet weak var charactersTableView: UITableView!
    
    private var controller: CharactersController = CharactersController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.charactersTableView.register(UINib(nibName: "CharactersTableCell", bundle: nil), forCellReuseIdentifier: "CharactersTableCell")
        
        self.charactersTableView.delegate = self
        self.charactersTableView.dataSource = self
        
        
        self.controller.getPersonagem { result in
            if result {
                self.charactersTableView.reloadData()
            } else {
                print("Erro")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
}

//MARK: - TableView properties

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharactersTableCell? = tableView.dequeueReusableCell(withIdentifier: "CharactersTableCell", for: indexPath) as? CharactersTableCell
        
        cell?.setup(value: self.controller.loadCurrentCharacter(indexPath: indexPath))
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Characters", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CharactersDetailViewController") as! CharactersDetailViewController
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
        vc.setup(value: self.controller.loadCurrentCharacter(indexPath: indexPath))
    }
}
