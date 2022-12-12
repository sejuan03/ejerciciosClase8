//
//  SellResumeViewController.swift
//  clase8Ejercicio2
//
//  Created by Mac on 12/12/22.
//

import UIKit

class SellResumeViewController: UIViewController {
    
    private struct Constant {
        static let imageNotFound = "interrogante"
    }
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var totalSellLabel: UILabel!
    @IBOutlet weak var payMethodImageView: UIImageView!
    
    
    var bookTitle: String?
    var price: Int?
    var quantity: Int?
    var payMethod: String?
    private var book: Book!
    private var bookSell: Sell!
    private var payMethodImage = ""
    let formatter = NumberFormatter()
    var sellPriceFormatted: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let bookTitle = bookTitle, let price = price, let quantity = quantity, let payMethod = payMethod else {
            return
        }
        book = Book(title: bookTitle)
        bookSell = Sell(quantity: quantity, price: price, payMethod: payMethod)
        preparePayMethodImage()
        validatePayMethodImageExist()
        formatTotalSellAsCurrency()
        showSellResume()
    }
    
    private func preparePayMethodImage() {
        payMethodImage = bookSell.payMethod
    }
    
    private func validatePayMethodImageExist() {
        guard UIImage(named: payMethodImage) != nil else {
            return payMethodImage = Constant.imageNotFound
        }
    }
    
    private func formatTotalSellAsCurrency() {
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        let decimalString = Decimal(string: bookSell.totalSell())
        sellPriceFormatted = formatter.string(for: decimalString)
    }
    
    private func showSellResume() {
        bookTitleLabel.text = book.title
        totalSellLabel.text = sellPriceFormatted
        payMethodImageView.image = UIImage(named: payMethodImage)
    }
    
}


