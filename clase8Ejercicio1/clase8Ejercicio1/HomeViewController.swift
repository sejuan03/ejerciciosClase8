//
//  HomeViewController.swift
//  clase8Ejercicio1
//
//  Created by Mac on 9/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private struct Constant {
        static let imageNotFound = "interrogante"
    }
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    var userEmail: String?
    private var userRepository = UserRepositoryImpl()
    private var currentUser: User!
    private var fullName = ""
    private var userPhoto = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userEmail = userEmail else {
            return
        }
        currentUser = userRepository.findUser(userEmail)
        prepareUserInformation()
        validateUserPhotoExist()
        showUserInformation()
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
