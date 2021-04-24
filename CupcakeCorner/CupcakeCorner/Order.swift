//
//  Order.swift
//  CupcakeCorner
//
//  Created by Nurbergen Yeleshov on 24.04.2021.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestOrdered = false {
        didSet {
            if specialRequestOrdered == false {
                extraFrostling = false
                addSprinkles =  false
            }
        }
    }
    @Published var extraFrostling = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        
        if extraFrostling {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
