//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Юрий on 08.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameRound = 0
    @State private var showingReset = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .indigo, location: 0.3),
                .init(color: .green, location: 0.3),
            ], center: .top, startRadius: 300, endRadius: 800)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 20) {
                    
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .shadow(radius: 10)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .shadow(radius: 10)
                
                Spacer()
            }
            .padding()
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            
            .alert("The End", isPresented: $showingReset) {
                        Button("Reset", action: resetGame)
                    } message: {
                        Text("Congratulations!\nYour score is \(score)")
                    }

        }
    }
    
    func flagTapped(_ number: Int) {
        gameRound += 1
        
        if number == correctAnswer {
            //gameRound += 1
      
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong. That’s the flag of \(countries[number])"
        }

        showingScore = true
        
        if gameRound == 8 {
                    showingReset = true
                } else {
                    showingScore = true
                }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
            gameRound = 0
            score = 0
        }
}

#Preview {
    ContentView()
}
