//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nurbergen Yeleshov on 06.03.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","US","UK"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0
    @State private var currentAnswer: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                VStack(spacing: 30) {
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .shadow(color: .black, radius: 2)
                                .rotationEffect(.degrees(number == currentAnswer ? 360 : 0))
                                .animation(.default)
                                
                        }
                    }
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            
            currentAnswer = number
            scoreTitle = "Correct"
            score += 1
            alertMessage = "Your score is \(score)"
            self.askQuestion()
            
        } else {
            scoreTitle = "Wrong"
            alertMessage = "That's the flag of \(countries[correctAnswer])"
            showingScore = true
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
