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
    @State var newCardOffset : CGPoint
    
    @State private var newCardColor = Color.red
    
    @State private var doneOffset = CGPoint(x: UIScreen.main.bounds.width / 2, y: (UIScreen.main.bounds.height / 4) - 20)
    
    @State private var defaultFrameWidth = CGFloat(175)
    @State private var defaultFrameHeight = CGFloat(125)
    @State private var shadow = CGFloat(0)
    
    @State private var isShowingDetailView = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.spring()) {
                    self.newCardOffset = value.location
                    self.newCardColor = Color.blue
                    
                    self.defaultFrameWidth = CGFloat(195)
                    self.defaultFrameHeight = CGFloat(145)
                    
                    self.shadow = CGFloat(10)
                }
            }
            .onEnded { value in
                withAnimation(.spring()) {
                    self.defaultFrameWidth = CGFloat(175)
                    self.defaultFrameHeight = CGFloat(125)
                    
                    self.shadow = CGFloat(0)

                    if value.location.y > doneOffset.y * 2 {
                        self.newCardColor = Color.green
                    } else {
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
            .frame(width: self.defaultFrameWidth, height: self.defaultFrameHeight, alignment: .center)
            .shadow(radius: self.shadow)
            .shadow(radius: self.shadow)
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
