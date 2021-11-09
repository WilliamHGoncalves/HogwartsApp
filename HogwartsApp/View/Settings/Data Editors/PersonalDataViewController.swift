//
//  PersonalDataViewController.swift
//  HogwartsApp
//
//  Created by Elena Diniz on 20/10/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import CryptoKit
import FirebaseAuth

class PersonalDataViewController: UIViewController {
    
    var ref: DatabaseReference!
    var userData: UserData!
    var email: String!
    
    @IBOutlet weak var viewMain: GradientView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var bdayTextField: UITextField!
    @IBOutlet weak var bdayDatePicker: UIDatePicker!
    @IBOutlet weak var saveButton: ButtonGradient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let auth = Auth.auth().currentUser
        if(auth != nil){
            self.email = auth?.email
        }
        ref = Database.database().reference().child("users")
//        let users = ref.child("users")
        let obj = ref.child(self.email!.toMD5())
        print("aaaaa obj", obj)
        obj.observe(DataEventType.value, with: {(dados) in
            let value = dados.value
            print("22222222", value is NSNull)
            do {
                if (value is NSNull){
                    self.creatNewUser(email: self.email)
                }
                else {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    self.userData = try JSONDecoder().decode(UserData.self, from: jsonData)
                    if(self.userData != nil) {
                        self.setLabels(userData: self.userData)
                    }
                }
            } catch let error {
                print("lalalalala")
            }
            
        })
        
        
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        bdayDatePicker.isHidden = true
        saveButton.layer.cornerRadius = saveButton.layer.frame.height / 2
        saveButton.layer.borderWidth = 1
        nameTextField.setEditingColor()
        nameTextField.isEnabled = true
        bdayTextField.setEditingColor()
        bdayTextField.isEnabled = true
        countryTextField.setEditingColor()
    }
    
    func setLabels(userData: UserData) {
        self.nameTextField.text = userData.nome
        self.bdayTextField.text = userData.dataNascimento
        self.countryTextField.text = userData.pais
    }
    
    func setNomeFirebase(email: String, nome: String){
        ref.child(email.toMD5()).child("nome").setValue(nome)
    }
    
    func setDataNascimentoFirebase(email: String, dataNascimento: String){
        ref.child(email.toMD5()).child("dataNascimento").setValue(dataNascimento)
    }
    
    func setPaisFirebase(email: String, pais: String){
        ref.child(email.toMD5()).child("pais").setValue(pais)
    }
    
    func creatNewUser(email: String) {
        ref.child(email.toMD5()).child("email").setValue(email)
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        self.setNomeFirebase(email: self.email, nome: self.nameTextField.text!)
        self.setDataNascimentoFirebase(email: self.email, dataNascimento: self.bdayTextField.text!)
        self.setPaisFirebase(email: self.email, pais: self.countryTextField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Strings

extension String {
    
    //    let hash = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
    func toMD5() -> String{
        return Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data()).map {
            String(format: "%02hhx", $0)
        }.joined()
        
    }
}
