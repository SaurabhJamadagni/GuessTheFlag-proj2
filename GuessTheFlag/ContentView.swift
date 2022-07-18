//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Admin on 17/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScoreAlert = false
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .purple, location: 0.1),
                .init(color: .mint, location: 0.9)
            ], center: .zero, startRadius: 300, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag!")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            checkAnswer(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreMessage, isPresented: $showingScoreAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func checkAnswer(_ number: Int) {
        if number == correctAnswer {
            scoreMessage = "Correct!"
            score += 1
        } else {
            scoreMessage = "Wrong :("
        }
        
        showingScoreAlert = true
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
