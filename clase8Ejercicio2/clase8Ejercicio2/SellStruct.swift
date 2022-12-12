//
//  SellStruct.swift
//  clase8Ejercicio2
//
//  Created by Mac on 12/12/22.
//

struct Sell {
    let quantity: Int
    let price: Int
    let payMethod: String
    
    func totalSell() -> String {
        return String(quantity*price)
    }
}
