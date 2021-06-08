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
    @State private var Listcards = [structCard]()
    @State private var isShowingAddCard = false
    @State private var newCardText = String()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.maxX - 15, height: 4, alignment: .center)
            
            Text("Você finalizou")
                .font(.title)
                .offset()
                .padding(.top, 50)
            
            VStack {
                Text("Suas tarefas")
                    .font(.title)
                
                ForEach(Listcards, id: \.nome) { nomeCard in
                    cards(textCard: nomeCard.nome)
                }
                
                Spacer()
                
                Button("Lembrar de algo") {
                    self.isShowingAddCard.toggle()
                }
                .sheet(isPresented: $isShowingAddCard) {
                    addCardView(newCardText: $newCardText)
                        .onDisappear() {
                            if self.newCardText != "" {
                                Listcards.append(structCard(nome: self.newCardText, id: UUID()))
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
