//
//  BeastsViewController.swift
//  HogwartsApp
//
//  Created by William Henrique Gonçalves Ribeiro on 03/10/21.
//

import UIKit

class BeastsViewController: UIViewController {

    @IBOutlet weak var viewMain: GradientView!
    @IBOutlet weak var beastsTableView: UITableView!
    
    private var controller: BeastsController = BeastsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.beastsTableView.register(UINib(nibName: "BeastTableCell", bundle: nil), forCellReuseIdentifier: "BeastTableCell")
        self.beastsTableView.delegate = self
        self.beastsTableView.dataSource = self
        
        self.controller.loadBeasts()
        title = "Animais Fantásticos"

        // Do any additional setup after loading the view.
    }

}

//MARK: - TableView properties
extension BeastsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BeastTableCell? = tableView.dequeueReusableCell(withIdentifier: "BeastTableCell", for: indexPath) as? BeastTableCell
        
        cell?.setup(value: self.controller.loadCurrentBeast(indexPath: indexPath))
        
        return cell ?? UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Beasts", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BeastsDetailViewController") as!
        BeastsDetailViewController
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
//      navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
        vc.setup(value: self.controller.loadCurrentBeast(indexPath: indexPath))
    }
}
