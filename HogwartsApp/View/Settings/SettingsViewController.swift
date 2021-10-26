//
//  SettingsViewController.swift
//  HogwartsApp
//
//  Created by Elena Diniz on 11/10/21.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var viewMain: GradientView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var changeProfileImageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseView: UIView!
    @IBOutlet weak var houseLogoImageView: UIImageView!
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    var buttonName = ["Dados Pessoais", "E-mail e Senha", "Sair"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        houseView.layer.cornerRadius = 5
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.frame = view.bounds
        settingsTableView.register(UINib(nibName: "ButtonTableCell", bundle: nil), forCellReuseIdentifier: "ButtonTableCell")
    }

    @IBAction func tappedChangeProfileImageButton(_ sender: UIButton) {
        let Alert = UIAlertController(title: "Opções de seleção", message: "Selecione a opção", preferredStyle: .actionSheet)
        let Gallery = UIAlertAction(title: "Imagem da Galeria", style: .default) {
            UIAlertAction in
            
//            print("Galeria")
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true)

        }
        let camera = UIAlertAction(title: "Tirar uma foto", style: .default) {
            UIAlertAction in

//            print("Camera")
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = .photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true)
            
        }
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .destructive)
        
        Alert.addAction(Gallery)
        Alert.addAction(camera)
        Alert.addAction(cancelar)
        
        self.present(Alert, animated: true, completion: nil)
    }
    
    private func alertLogOut() {
        let alert = UIAlertController(title: "ATENÇÃO!", message: "Deseja realmente deslogar de sua conta?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Continuar", style: .default) { _ in
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                print("Usuário deslogado")
                self.continueToLogin()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func continueToLogin() {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ButtonTableCell? = tableView.dequeueReusableCell(withIdentifier: "ButtonTableCell", for: indexPath) as? ButtonTableCell
        
        cell?.buttonName.text = buttonName[indexPath.row]
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let buttons = buttonName[indexPath.row]
        
        if buttons == "Dados Pessoais" {
            let storyboard = UIStoryboard(name: "UserSettings", bundle: nil)
            let personalData = storyboard.instantiateViewController(withIdentifier: "PersonalDataViewController") as! PersonalDataViewController
            personalData.providesPresentationContextTransitionStyle = true
            personalData.definesPresentationContext = true
            personalData.modalPresentationStyle = .automatic
            self.present(personalData, animated: true)
        } else if buttons == "E-mail e Senha" {
            let storyboard = UIStoryboard(name: "UserSettings", bundle: nil)
            let email = storyboard.instantiateViewController(withIdentifier: "EmailEditorViewController") as! EmailEditorViewController
            email.providesPresentationContextTransitionStyle = true
            email.definesPresentationContext = true
            email.modalPresentationStyle = .automatic
            self.present(email, animated: true)
        } else if buttons == "Sair" {
            self.alertLogOut()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
//            selectedImage = editedImage
            self.profileImageView.image = editedImage
            picker.dismiss(animated: true)
            
        }else if let originalImage = info[.originalImage] as? UIImage{
//            selectedImage = originalImage
            self.profileImageView.image = originalImage
            picker.dismiss(animated: true)
            
        }else {
            print("Erro")
        }
        
//        self.profileImageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Usuario cancelou o processo")
    }
}
