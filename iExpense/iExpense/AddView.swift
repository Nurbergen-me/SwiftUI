//
//  AddView.swift
//  iExpense
//
//  Created by Nurbergen Yeleshov on 02.04.2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expense: Expences
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingAlert = false
    
    static let types = ["Personal","Business"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Add") {
                if let actualAmount = Int(amount) {
                    let expence = ExpenceItem(name: name, type: type, amount: actualAmount)
                    expense.items.append(expence)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingAlert.toggle()
                }
            })
            
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Alert message"), message: Text("Text '\(amount)' can not be converted to amount"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expense: Expences())
    }
}
