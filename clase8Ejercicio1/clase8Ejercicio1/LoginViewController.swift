//
//  LoginViewController.swift
//  clase8Ejercicio1
//
//  Created by Mac on 9/12/22.
//
import UIKit

class LoginViewController: UIViewController {
    
    private struct Constant {
        static let errorTittle = "Error"
        static let alertCancelAction = "Cancelar"
        static let expectedUser = [("claudia@","12345"),("hola@test.com","23456")]
        static let serverError = "Error de Red"
        static let emptyFieldsMessage = "Llenar todos los datos"
        static let failureMessage = "Credenciales Invalidas"
        static let segueToHomeView = "goToHome"
        static let successMessage = "Exito"
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var message = ""
    private var alertError: UIAlertController!
    private var serverNumber = 1
    private var serverError = false
    private var validCredentials = false
    private var email = ""
    private var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createErrorAlert()
    }
    
    private func createErrorAlert() {
        alertError = UIAlertController(title: Constant.errorTittle, message: message, preferredStyle: .alert)
        let errorAlertCancelAction = UIAlertAction(title: Constant.alertCancelAction, style: .cancel)
        alertError.addAction(errorAlertCancelAction)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        updateServer()
        checkServer()
        prepareCredentials()
        validateCredentials()
        processAccessAction()
        processResultMessage()
    }
    
    private func updateServer() {
        serverNumber = Int.random(in: 1...5)
    }
    
    private func checkServer() {
        serverError = serverNumber % 2 != 0
    }
    
    private func prepareCredentials() {
        email = emailTextField.text ?? ""
        password = passwordTextField.text ?? ""
    }
    
    private func validateCredentials() {
        validCredentials = Constant.expectedUser.contains { uEmail,uPass in uEmail == email && uPass == password}
    }
    
    private func processAccessAction() {
        if email.isEmpty && password.isEmpty {
            message = Constant.emptyFieldsMessage
        } else if !validCredentials {
            message = Constant.failureMessage
        } else if serverError {
            message = Constant.serverError
        } else {
            message = Constant.successMessage
        }
    }
    
    private func processResultMessage() {
        switch(message) {
        case Constant.successMessage: goToHomeView()
        default: setupErrorAlertMessage()
            presentErrorAlert()
        }
    }
    
    private func goToHomeView() {
        performSegue(withIdentifier: Constant.segueToHomeView, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let homeViewController = segue.destination as? HomeViewController else {
            return
        }
        homeViewController.userEmail = email
    }
    
    private func setupErrorAlertMessage() {
        alertError.message = message
    }
    
    private func presentErrorAlert() {
        present(alertError, animated: true)
    }
}
