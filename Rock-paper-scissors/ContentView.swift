//
//  ContentView.swift
//  Rock-paper-scissors
//
//  Created by Mathieu Dubart on 05/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["🤜", "🫲", "✌️"]
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var questionNumber = 1
    @State private var isEnded = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack {
                    Text("Computer has played...")
                    Text(moves[computerChoice])
                        .font(.system(size: 100))
                        .padding(10)
                }
                .font(.subheadline)
                HStack {
                    Text(shouldWin ? "Which one wins?" : "Which one loses?")
                        .foregroundColor(shouldWin ? .green : .red)
                }
                .font(.title)
            }
            
            Spacer()
            
            HStack {
                ForEach(0..<3) { number in
                    Button(moves[number]) {
                        play(choice: number)
                    }
                    .font(.system(size:50))
                    .padding(20)
                }
            }
            
            Spacer()
            
            Text("Score: \(playerScore)")
                .font(.title3)
            
            Spacer()
            Spacer()
        }
        .alert("Game end", isPresented: $isEnded) {
            Button("Play again"){
                restartGame()
            }
        } message: {
            Text("Your score is \(playerScore)/\(questionNumber)")
        }
        .padding()
    }
    
    func play(choice: Int) -> Void {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        calculateScore(didWin)
    }
    
    func calculateScore(_ didWin:Bool) -> Void {
        didWin ? (playerScore += 1) : (playerScore -= 1)
        isGameEnded()
    }
    
    func isGameEnded() -> Void {
        if (questionNumber >= 10) {
            isEnded = true
        } else {
            questionNumber += 1
            nextQuestion()
        }
    }
    
    func nextQuestion() -> Void {
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    func restartGame() -> Void {
        questionNumber = 1
        playerScore = 0
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
