//
//  ContentView.swift
//  kaban
//
//  Created by 0rientd on 04/06/21.
//
//
// CONSERTAR BUG ONDE O SEGUNDO CARD APARECE EMBAIXO

import SwiftUI

struct ContentView: View {
    @State private var listCards = [structCard]()
    @State private var isShowingAddCard = false
    @State private var newCardText = String()
    
    @State private var newCardOffset = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 4)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.maxX - 15, height: 4, alignment: .center)
            
            Text("Você finalizou")
                .font(.title)
                .padding(.top, 50)
            
            VStack {
                Text("Suas tarefas")
                    .font(.title)
                
                Spacer()
            }
            
                ForEach(listCards, id: \.nome) { nomeCard in
                    ZStack {
                        cards(textCard: nomeCard.nome, newCardOffset: self.newCardOffset)
                    }
                }
             
            VStack {
                Spacer()
                
                Button("Lembrar de algo") {
                    self.isShowingAddCard.toggle()
                }
                .sheet(isPresented: $isShowingAddCard) {
                    addCardView(newCardText: $newCardText)
                        .onDisappear() {
                            if self.newCardText != "" {
                                listCards.append(structCard(nome: self.newCardText, id: UUID()))
                                self.newCardText = String()
                            }
                        }
                }
            }
        }
    }
}

struct addCardView : View {
    @Binding var newCardText: String
    
    var body: some View {
        ZStack {
            VStack {
                Text("O que deseja lembrar?")
                
                RoundedRectangle(cornerRadius: 15.0)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .frame(width: 350, height: 40, alignment: .center)
                    .overlay(
                        TextField("Digite aqui", text: $newCardText)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50, alignment: .center)
                    )
            }
        }
    }
}

struct detailCardView: View {
    var body: some View {
        VStack {
            Text("Details here")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
