//
//  ContentView.swift
//  Convercity
//
//  Created by Nurbergen Yeleshov on 04.03.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var firstCurreny = 0
    @State private var secondCurrenty = 2
    @State private var currentAmount = ""
    
    let currencies = ["USD","EUR","RUB","KZT","CNY"]
    let currentRates = [1,0.84,73.9,420,6.47]
    
    var conversion: Double {
        let amount = Double(currentAmount) ?? 0
        let inDollar = amount / currentRates[firstCurreny]
        let finalAmount = inDollar * currentRates[secondCurrenty]
        return finalAmount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Choose first currency", selection: $firstCurreny) {
                        ForEach(0..<currencies.count) {
                            Text("\(currencies[$0])")
                        }
                    }
                    Picker("Choose second currency", selection: $secondCurrenty) {
                        ForEach(0..<currencies.count) {
                            Text("\(currencies[$0])")
                        }
                    }
                }
                Section {
                    TextField("From \(currencies[firstCurreny])", text: $currentAmount)
                }
                Section {
                    Text("\(conversion, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Convercity")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
