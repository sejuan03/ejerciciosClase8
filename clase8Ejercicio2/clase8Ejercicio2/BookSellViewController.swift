//
//  ViewController.swift
//  clase8Ejercicio2
//
//  Created by Mac on 12/12/22.
//

import UIKit

class BookSellViewController: UIViewController {
    
    private struct Constant {
        static let errorTittle = "Error"
        static let alertCancelAction = "Cancelar"
        static let wrongPriceQuantityValues = "Valores Invalidos"
        static let serverError = "Error de Red"
        static let emptyFieldsMessage = "Llenar todos los datos"
        static let failureMessage = "Credenciales Invalidas"
        static let segueToSellResumeView = "goToSellResumeView"
        static let successMessage = "Exito"
    }
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookPriceTextField: UITextField!
    @IBOutlet weak var bookQuantityTextField: UITextField!
    @IBOutlet weak var payMethodPullDownButton: UIButton!
    
    private var message = ""
    private var alertError: UIAlertController!
    private var errorAlertCancelAction: UIAlertAction!
    private var payMethodType = ""
    private var serverNumber = 1
    private var serverError = false
    private var bookTitle = ""
    private var priceS = ""
    private var quantityS = ""
    private var fieldsAreNotEmpty = false
    private var valuesAreNumeric = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createErrorAlert()
        setupAlertActions()
        addAlertActions()
        setIdTypePopUpButton()
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
    
    private func setIdTypePopUpButton() {
        setPopUpMenu()
        payMethodType = payMethodPullDownButton.titleLabel?.text ?? ""
    }
    
    private func setPopUpMenu() {
        payMethodPullDownButton.menu = UIMenu(children : [createChildAction("Efectivo"),createChildAction("Credito")])
    }
    
    private func createChildAction(_ title : String) -> UIAction {
        return UIAction(title: title, handler: createOptionHandler())
    }
    
    private func createOptionHandler() -> (UIAction) -> () {
        return {(action : UIAction) in self.payMethodType = action.title}
    }
    
    @IBAction func onSellButtonTapped(_ sender: Any) {
        updateServer()
        checkServer()
        prepareData()
        validateData()
        setMessageResult()
        processMessageResult()
    }
    
    private func updateServer() {
        serverNumber = Int.random(in: 1...7)
    }
    
    private func checkServer() {
        serverError = serverNumber % 2 != 0
    }
    
    private func prepareData() {
        bookTitle = bookTitleTextField.text ?? ""
        priceS = bookPriceTextField.text ?? ""
        quantityS = bookQuantityTextField.text ?? ""
    }
    
    private func validateData() {
        fieldsAreNotEmpty = !bookTitle.isEmpty && !priceS.isEmpty && !quantityS.isEmpty
        valuesAreNumeric = Int(priceS) != nil && Int(quantityS) != nil
    }
    
    private func setMessageResult(){
        guard fieldsAreNotEmpty else {
            return message = Constant.emptyFieldsMessage
        }
        guard valuesAreNumeric else {
            return message = Constant.wrongPriceQuantityValues
        }
        guard !serverError else {
            return message = Constant.serverError
        }
        message = Constant.successMessage
    }
    
    private func processMessageResult() {
        switch(message) {
        case Constant.successMessage: performSellAction()
        default: presentErrorAlert()
        }
    }
    
    private func performSellAction() {
        performSegue(withIdentifier: Constant.segueToSellResumeView, sender: self)
    }
    
    private func presentErrorAlert() {
        alertError.message = message
        present(alertError, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sellResumeViewController = segue.destination as? SellResumeViewController else {
            return
        }
        guard let price = Int(priceS), let quantity = Int(quantityS) else {
            return
        }
        sellResumeViewController.bookTitle = bookTitle
        sellResumeViewController.price = price
        sellResumeViewController.quantity = quantity
        sellResumeViewController.payMethod = payMethodType
        resetSellFormFields()
    }
    
    private func resetSellFormFields(){
        bookTitleTextField.text = ""
        bookPriceTextField.text = ""
        bookQuantityTextField.text = ""
    }
    
}

