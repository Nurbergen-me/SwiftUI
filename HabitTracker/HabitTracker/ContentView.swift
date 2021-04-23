//
//  ContentView.swift
//  HabitTracker
//
//  Created by Nurbergen Yeleshov on 10.04.2021.
//

import SwiftUI

struct Habit: Codable {
    var habit: String
    var description: String
    var total: Int?
}

struct NewHabit: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name of the Habit:", text: $name)
                TextField("Description:", text: $description)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Add"){
                let habit = Habit(habit: name, description: description)
                
                habits.habits.insert(habit, at: 0)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
}

struct AddValue: View {
    @State var habit: Habit
    @State private var amount = ""
    @State private var total = 0
      
    
    var body: some View {
        VStack {
            Form {
                TextField("Amount of:", text: $amount)
                Spacer()
                Button("Submit") {
                    total = habit.total ?? 0
                    habit.total = total + Int(amount)!
                    
                }
            }
        }
    }
}

class Habits: ObservableObject {
    
    @Published var habits = [Habit]()
    
    init() {
        self.habits = Bundle.main.decode("habits.json")
    }
}

struct ContentView: View {
    @ObservedObject var habits = Habits()
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.habits, id: \.habit) { habit in
                    NavigationLink(destination: AddValue(habit: habit)) {
                        VStack(alignment: .leading) {
                            Text(habit.habit)
                                .font(.headline)
                            Text(habit.description)
                        }
                        Spacer()
                        Text("\(habit.total ?? 0)")
                    }
                }
            }
            .navigationBarTitle("HabitTracker")
            .navigationBarItems(trailing: Button("\(Image.init(systemName: "plus"))"){
                self.showingSheet.toggle()
            })
            .sheet(isPresented: $showingSheet) {
                NewHabit(habits: habits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
