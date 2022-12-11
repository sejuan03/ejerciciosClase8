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
    private var errorAlertCancelAction: UIAlertAction!
    private var serverNumber = 1
    private var serverError = false
    private var successAccess = false
    private var email = ""
    private var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createErrorAlert()
        setupAlertActions()
        addAlertActions()
    }
    
    private func createErrorAlert() {
        alertError = UIAlertController(title: Constant.errorTittle, message: message, preferredStyle: .alert)
    }
    
    private func setupAlertActions() {
        errorAlertCancelAction = UIAlertAction(title: Constant.alertCancelAction, style: .cancel)
    }
    
    private func addAlertActions() {
        alertError.addAction(errorAlertCancelAction)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let homeViewController = segue.destination as? HomeViewController else {
            return
        }
        guard let email = emailTextField?.text else {
            return
        }
        homeViewController.userEmail = email
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        updateServer()
        checkServer()
        prepareCredentials()
        successAccessInstance()
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
    
    private func successAccessInstance() {
        successAccess = Constant.expectedUser.contains { uEmail,uPass in uEmail == email && uPass == password}
    }
    
    private func processAccessAction() {
        guard !email.isEmpty && !password.isEmpty else {
            return message = Constant.emptyFieldsMessage
        }
        guard successAccess else {
            return message = Constant.failureMessage
        }
        guard serverError == false else {
            return message = Constant.serverError
        }
        if successAccess {
            message = Constant.successMessage
        }
    }
    
    private func processResultMessage() {
        switch(message) {
        case Constant.successMessage: successfullInstance()
        default: presentErrorAlert()
        }
    }
    
    private func successfullInstance() {
        performSegue(withIdentifier: Constant.segueToHomeView, sender: self)
    }
    
    private func presentErrorAlert() {
        alertError.message = message
        present(alertError, animated: true)
    }
}
