//
//  CharactersDetailViewController.swift
//  HogwartsApp
//
//  Created by William Henrique Gonçalves Ribeiro on 03/10/21.
//

import UIKit

class CharactersDetailViewController: UIViewController {
    
    @IBOutlet weak var viewMain: GradientView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveFavoriteButton: UIButton!
    
    var imageURL: String = ""
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveFavoriteButton.layer.cornerRadius = saveFavoriteButton.frame.height / 2
        characterImage.layer.cornerRadius = 5
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedSaveFavoriteButton(_ sender: UIButton) {
        
    }
    
    func setup(value: Character) {
        let varinha: String = value.wand.wood
        self.titleLabel.text = value.name
        self.descriptionLabel.text = " Espécie: \(value.species) \n Gênero: \(value.gender)\n Data de nascimento: \(value.dateOfBirth) \n Casa: \(value.house) \n Ancestralidade: \(value.ancestry) \n Cor dos olhos: \(value.eyeColour) \n Cor dos cabelos: \(value.hairColour) \n Patrono: \(value.patronus) \n Varinha: \(varinha) \n Ator: \(value.actor)"
        self.characterImage.downloaded(from: value.image)
    }
    
    private func loadImageView() {
        guard let urlImage = URL(string: imageURL) else { return }
        
        do {
            let dataImage = try Data(contentsOf: urlImage)
            let imageData = UIImage(data: dataImage)
            characterImage.image = imageData
        } catch let error {
            print("Error Image: \(error.localizedDescription)")
        }
        
    }
}

extension UIImageView {
    func downloadedDetail(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloadedDetail(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

