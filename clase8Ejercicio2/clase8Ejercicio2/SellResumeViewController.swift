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
    
    var book: Book?
    var bookSell: Sell?
    private var bookTittle : String!
    private var bookRSell: Sell!
    private var payMethodImage = ""
    private let formatter = NumberFormatter()
    private var sellPriceFormatted: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let book = book, let bookSell = bookSell else {
            return
        }
        bookTittle = book.title
        bookRSell = bookSell
        preparePayMethodImage()
        validatePayMethodImageExist()
        formatTotalSellAsCurrency()
        showSellResume()
    }
    
    private func preparePayMethodImage() {
        payMethodImage = bookSell?.payMethod ?? Constant.imageNotFound
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
        let decimalString = Decimal(string: bookRSell.totalSell())
        sellPriceFormatted = formatter.string(for: decimalString)
    }
    
    private func showSellResume() {
        bookTitleLabel.text = bookTittle
        totalSellLabel.text = sellPriceFormatted
        payMethodImageView.image = UIImage(named: payMethodImage)
    }
    
}


