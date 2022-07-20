//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Saurabh Jamadagni on 17/07/22.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScoreAlert = false
    @State private var receievedWrongAns = false
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var questionsAsked = 0
    @State private var receivedAns = ""
    
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
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.yellow, .teal]), startPoint: .leading, endPoint: .trailing))
                
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
                            receivedAns = countries[number]
                            checkAnswer(number)
                            askQuestion()
                        } label: {
                            FlagImage(country: countries[number])
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
        .alert(scoreMessage, isPresented: $receievedWrongAns) {
            Button("OK") { }
        } message: {
            Text("That's the flag of \(receivedAns)")
        }
        
        .alert("Game Over", isPresented: $showingScoreAlert) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func checkAnswer(_ number: Int) {
        if number == correctAnswer {
            scoreMessage = "Correct!"
            // removes the current asked country to avoid repetion
            let _ = countries.remove(at: number)
            score += 1
        } else {
            scoreMessage = "Wrong :("
            receievedWrongAns = true
        }
        questionsAsked += 1
        if questionsAsked == 8 {
            showingScoreAlert = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        questionsAsked = 0
        // we reassign countries to have all the countries again.
        countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
