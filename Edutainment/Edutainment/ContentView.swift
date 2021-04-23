//
//  ContentView.swift
//  Edutainment
//
//  Created by Nurbergen Yeleshov on 01.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var currentQuestion = "4 * 8 = ?"
    @State private var score = 0
    @State private var answers = [25,32,45]
    @State private var currentAnswer = 32
    @State private var choosenAnswers = [Int]()
    @State private var checkAnswers = [Bool]()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.yellow,.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 350, height: 200)
                        .cornerRadius(20)
                    VStack {
                        Text(currentQuestion)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(10)
                        Text("First Level")
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    
                }
                VStack {
                    let rows = Int(choosenAnswers.count / 5) + 1
                    ForEach(0..<rows) { row in
                        let count = choosenAnswers.count % 5
                        let currentRow = (choosenAnswers.count - (row+1)*5 >= 0) ? 5 : count
                        HStack {
                            ForEach(0..<currentRow, id: \.self) {
                                Text("\(choosenAnswers[row*5 + $0]) \(rows)")
                                .frame(width: 50, height: 50)
                                    .background(checkAnswers[$0] ? Color.green : Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.title)
                            }
                        }
                    }
                    
                }
                Spacer()
                HStack {
                    ForEach(0..<answers.count) { number in
                        Button("\(answers[number])") {
                            self.newQuestion(answer: answers[number])
                        }
                        .frame(width: 80, height: 50)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.title)
                    }
                    
                }
                Spacer().frame(height: 50)
            }
            .navigationBarTitle("Edutainment", displayMode: .automatic)
            .navigationBarItems(leading: Button("Restart") {
                
            }, trailing: Text("Score: \(score)"))
            
        }
    }
    
    
    func newQuestion(answer: Int) {
        choosenAnswers.append(answer)
        if currentAnswer ==  answer {
            checkAnswers.append(true)
            score += 1
        } else {
            checkAnswers.append(false)
        }
        
        
        let firstNumber = Int.random(in: 2...9)
        let secondNumber =  Int.random(in: 2...9)
        let symbols = ["+","-","/","*"].shuffled()
        
        if symbols[0] == "+" {
            currentAnswer = firstNumber + secondNumber
            
        } else if symbols[0] == "-" {
            currentAnswer = firstNumber - secondNumber
            
        } else if symbols[0] == "*" {
            currentAnswer = firstNumber * secondNumber
            
        } else if symbols[0] == "/" {
            currentAnswer = firstNumber / secondNumber
        }
        currentQuestion = "\(firstNumber) \(symbols[0]) \(secondNumber) = ?"
        answers[0] = currentAnswer
        answers.shuffle()
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
