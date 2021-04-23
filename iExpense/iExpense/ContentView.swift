//
//  ContentView.swift
//  iExpense
//
//  Created by Nurbergen Yeleshov on 02.04.2021.
//

import SwiftUI


struct ExpenceItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Int
}

class Expences: ObservableObject {
    @Published var items = [ExpenceItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
            
        }
    }
    
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenceItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expences = Expences()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expences.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text("\(item.amount)")
                        }
                        .listRowBackground(item.type == "Personal" ? Color.green : Color.blue)
                        .foregroundColor(.white)
                    }
                    .onDelete(perform: removeItem)
                    .onMove(perform: move)
                    HStack {
                        Text("Total amount")
                        Spacer()
                        Text("1000000")
                    }
                }
                
                
            }
            .navigationTitle("iExpence")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddExpense.toggle()
            }) {
                Image(systemName: "plus")
            })
            
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expense: expences)
            })
            
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        expences.items.remove(atOffsets: offsets)
    }
    func move(from source: IndexSet, to destination: Int) {
        expences.items.move(fromOffsets: source, toOffset: destination)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
