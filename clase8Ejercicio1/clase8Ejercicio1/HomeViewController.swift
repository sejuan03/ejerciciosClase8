//
//  HomeViewController.swift
//  clase8Ejercicio1
//
//  Created by Mac on 9/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private struct Constant {
        static let userDB = [User(name: "Juan", lastName: "Sebastian", email: "hola@test.com", photo: "JuanPhoto"),User(name: "Claudia", lastName: "Isabel", email: "claudia@", photo: "ClaudiaPhoto")]
        static let imageNotFound = "interrogante"
    }
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    var userEmail: String?
    private var currentUser: User!
    private var fullName = ""
    private var userPhoto = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userEmail = userEmail else {
            return
        }
        findUser(userEmail)
        prepareUserInformation()
        validateUserPhotoExist()
        showUserInformation()
    }
    
    private func findUser(_ email: String) {
        currentUser = Constant.userDB.first { user in
            user.email == email
        }
    }
    
    private func prepareUserInformation() {
        fullName = "\(currentUser.name) \(currentUser.lastName)"
        userPhoto = currentUser.photo
    }
    
    private func validateUserPhotoExist() {
        guard UIImage(named: userPhoto) != nil else {
            return userPhoto = Constant.imageNotFound
        }
    }
    
    private func showUserInformation() {
        fullNameLabel.text = fullName
        userPhotoImageView.image = UIImage(named: userPhoto)
    }
    
    @IBAction func onSignOutTapped() {
        dismiss(animated: true)
    }
}
