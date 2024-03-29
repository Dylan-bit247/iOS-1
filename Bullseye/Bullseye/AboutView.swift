//
//  AboutView.swift
//  Bullseye
//
//  Created by Dylan Macdonald on 9/22/21.
//

import SwiftUI

struct AboutView: View {
    
    let beige = Color(red: 1.0,
                      green: 0.84,
                      blue: 0.7)
    
    var body: some View {
        VStack{
            Text("🎯 Bullseye 🎯")
                .modifier(AboutHeadingStyle())
                .navigationBarTitle("About Bullseye")
            Text("this is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(AboutBodyStyle())
            Text("as close as possible to the targer value. The closet you are, the more points you score.")
                .modifier(AboutBodyStyle())
            Text("Enjoy")
                .modifier(AboutBodyStyle())
        }
        .background(beige)
    
        .background(Image("Background"))
}
}

struct AboutHeadingStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 30))
            .foregroundColor(Color.black)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}

struct AboutBodyStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .foregroundColor(Color.black)
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
