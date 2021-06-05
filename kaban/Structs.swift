//
//  Structs.swift
//  kaban
//
//  Created by 0rientd on 05/06/21.
//

import Foundation
import SwiftUI


//-- Data Struct for cards
struct structCard {
    var nome: String
    var id: UUID
}


//-- Card Function and struct
struct cards : View {
    @State var textCard : String
    @State private var newCardColor = Color.red
    
    @State private var newCardOffset = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 4)
    @State private var doneOffset = CGPoint(x: UIScreen.main.bounds.width / 2, y: (UIScreen.main.bounds.height / 4) - 20)
    @State private var isShowingDetailView = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.spring()) {
                    self.newCardOffset = value.location
                    self.newCardColor = Color.blue
                }
            }
            .onEnded { value in
                if value.location.y > doneOffset.y * 2 {
                    withAnimation(.easeInOut) {
                        self.newCardColor = Color.green
                    }
                } else {
                    withAnimation(.spring()) {
                        self.newCardColor = Color.red
                    }
                }
            }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .overlay(
                Text(textCard)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            )
            .foregroundColor(newCardColor)
            .frame(width: 175, height: 125, alignment: .center)
            .position(newCardOffset)
            .gesture(
                drag
            )
            .onTapGesture {
                self.isShowingDetailView.toggle()
            }
            .sheet(isPresented: $isShowingDetailView) {
                detailCardView()
            }
    }
}
