//
//  BeastsDetailViewController.swift
//  HogwartsApp
//
//  Created by William Henrique Gonçalves Ribeiro on 03/10/21.
//

import UIKit

class BeastsDetailViewController: UIViewController {

    @IBOutlet weak var viewMain: GradientView!
    @IBOutlet weak var beastNameLabel: UILabel!
    @IBOutlet weak var beastImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: ButtonGradient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height / 2
        beastImageView.layer.cornerRadius = 5
    }
    
    @IBAction func tappedFavoriteButton(_ sender: UIButton) {
    }
    
    func setup(value: Beasts) {
        self.beastImageView?.image = UIImage(named: value.avatar ?? "")
        self.descriptionLabel?.text = " Nome: \(value.name ?? "") \n Característias: \(value.characteristics ?? "")"
        self.beastNameLabel.text = (value.name ?? "")
    }
    
}


