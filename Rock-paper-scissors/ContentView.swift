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
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack {
                    Text("If I choose")
                    Text(moves[computerChoice])
                        .font(.system(size: 100))
                        .padding(10)
                }
                .font(.title)
                HStack {
                    Text("and I want you to")
                    Text(shouldWin ? "win" : "lose")
                        .foregroundColor(shouldWin ? .green : .red)
                }
                .font(.title)
            }
            .padding(10)
            
            HStack {
                Text("What must you choose?")
            }
            .font(.title2)
            .padding(5)
            
            Spacer()
            
            HStack {
                ForEach(0..<3) { number in
                    Button(moves[number]) {
                        play(choice: number)
                        restartGame()
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
    }
    
    func restartGame() -> Void {
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
