//
//  ContentView.swift
//  GuessTheFlagUI
//
//  Created by Efe Sezen on 23.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries:[String] = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
    @State private var alertShown:Bool = false
    @State private var score:Int = 0
    @State private var result:Int = Int.random(in: 0..<3)
    @State private var scoreTitle:String = ""
    var body: some View {
        ZStack{
            LinearGradient(colors: [.red,.blue,.white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(spacing:30){
                VStack{
                Text("What is the flag of")
                        .bold()
                    Text(countries[result])
                        .fontWeight(.semibold)
                        .font(.title)
                }.foregroundStyle(.white)

                ForEach(0..<3, id: \.self){ number in
                    Button{
                        checkAnswer(number)
                    } label:{
                        Image(countries[number]).cornerRadius(10)
                    }
                    .alert(scoreTitle,isPresented: $alertShown){
                        Button("Next Question"){nextQuestion()}
                    } message: {Text("Your score is \(score)")}
                }
                Text("Your score is \(score)").bold()
            }
            
        }
    }
    
    func checkAnswer (_ number:Int){
        if number == result {
            scoreTitle = "Right"
            score += 1
        } else {
            scoreTitle = "Wrong"
            if score <= 0 {
                score = 0
            } else{
                score -= 1
            }
        }
        alertShown = true
    }
    
    func nextQuestion (){
        countries.shuffle()
        result = Int.random(in:0..<3)
    }
}

#Preview {
    ContentView()
}
