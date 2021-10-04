//
//  ContentView.swift
//  Bullseye
//
//  Created by Dylan Macdonald on 8/22/21.
//

import SwiftUI
import UIKit
import WebKit



struct ContentView: View {
    
    //color-
    let midnightBlue = Color(red:0,
                             green: 0.2,
                             blue: 0.4)
    
    //game stats-
    @State var score = 0
    @State var round = 1
    
    //interface view-
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    var sliderValueRounded: Int {
        Int(sliderValue.rounded())
    }
    var sliderTargetDifference: Int{
        abs(sliderValueRounded - target)
    }
    
    //interface content & layout-
    var body: some View {
        NavigationView {
            
            VStack {
                Spacer().navigationBarTitle("🎯 Bullseye 🎯")
                //target row-
                HStack{
                    Text("Put the bullseye as close as you can to:")
                        .font(Font.custom("Arial Rounded MT Bold", size: 18))
                        .foregroundColor(.white)
                        .modifier(Shadow())
                    Text("\(target)")
                        .font(Font.custom("Arial Rounded MT Bold", size: 24))
                        .foregroundColor(.yellow)
                    
                }
                
                //slider row-
                HStack{
                    Text("1")
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(Color.green)
                        .animation(.easeOut)
                    Text("100")
                }
                
                
                
                //button row-
                Button(action: {
                    print("Points awarded: \(pointsForCurrentRound())")
                    alertIsVisible = true
                }){
                    //buttons text-
                    Text("Hit me!").modifier(ButtonLargeTextStyle())
                }
                    .background(Image("Button-Normal"))
                    .modifier(Shadow())
                //pop up text and info-
                .alert(isPresented: $alertIsVisible){
                    Alert(title: Text(alertTitle()),
                          message: Text(scoringMessage()),
                          dismissButton: .default(Text("Awesome!")) {
                            startNewRound()
                          }
                    )}
                
                 Spacer()
                
                //score row-
                HStack{
                    Button(action: {
                        startNewGame()
                    }){
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                    .background(Image("Button-Normal"))
                    .modifier(Shadow())

                    Spacer()
                    Text("Score:")
                    Text("\(score)")
                    Spacer()
                    Text("round:")
                    Text("\(round)")
                    Spacer()
                    NavigationLink(destination: AboutView()) {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                    .background(Image("Button-Normal"))
                    .modifier(Shadow())
                }
                .padding(.bottom, 20)
                .accentColor(midnightBlue)
            }
            .onAppear(){
                startNewGame()
            }
            .background(Image ("Background"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    //methods-
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let points: Int
        
        if sliderTargetDifference == 0 {
            points = 200
        } else if  sliderTargetDifference == 1 {
            points = 150
        } else {
            points = maximumScore - sliderTargetDifference
        }
        
        return points
    }
    
    func scoringMessage() -> String{
        return "The slider's value is \(Int(sliderValueRounded)).\n"+"The target value is \(target).\n"+"You scored \(pointsForCurrentRound()) points this round."
    }
    
    func alertTitle() -> String {
        let title: String
        
        if sliderTargetDifference == 0 {
            title = "Perfect!"
        } else if sliderTargetDifference < 5 {
            title = "You almost had it!"
        } else if sliderTargetDifference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func startNewGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
    
    func startNewRound() {
        score = score +  pointsForCurrentRound()
        round = round + 1
        resetSliderAndTarget()
        
    }
    
    func resetSliderAndTarget() {
        target = Int.random(in:1...100)
        sliderValue = 50
    }
    
}


//pre-preview
struct Shadow: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
}

struct ButtonLargeTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(Color.black)
    }
}

struct ButtonSmallTextStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size:12))
            .foregroundColor(Color.black)
    }
}

struct ValueStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
            .foregroundColor(Color.yellow)
            .modifier(Shadow())
    }
}

//preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
