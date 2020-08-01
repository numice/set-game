import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    var isDeckEmpty: Bool {
        self.viewModel.deck.filter { !$0.isDealt }.count <= 0
    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("New Game") { self.viewModel.newGame() }.padding()
            }
            Group {
                if viewModel.deck.filter { !$0.isMatched }.count > 0 {
                    Grid(viewModel.deck.filter {
                        $0.isDealt && ( !$0.isMatched || $0.isMatched && $0.isSelected )
                    }) { card in
                        
                        CardView(
                            card: card,
                            theme: self.viewModel.defaultTheme
                        )
                        .transition(.asymmetric(
                            insertion: AnyTransition.offset(x: 100, y: 100),
                            removal: AnyTransition.move(edge: .trailing)))
                        .animation(.easeInOut(duration: 0.3))
                        .onTapGesture { self.viewModel.select(card: card) }
                        .padding(5)
                    }
                } else {
                    Text("Game Over").fontWeight(.black)
                }
                
            }
            .padding(5)
            HStack {
                Spacer()
                Button("Deal") {
                    self.viewModel.deal()
                }
                .padding(10)
                .foregroundColor(Color.white)
                .background(isDeckEmpty ?
                    RoundedRectangle(cornerRadius: 10).fill(Color.gray) :
                    RoundedRectangle(cornerRadius: 10).fill(Color.green))
                .disabled(isDeckEmpty)
                
                
            }.frame(height: 80).padding(5)
        }
    }
}

struct CardView: View {
    var card: SetGame<[Int]>.Card
    var theme: Theme
    
    var body: some View {
        
            VStack {
//                Text(card.feature.map { String($0) }.reduce(" ") { $0 + $1 } )
                theme.getContent(features: card.feature)
            }
            .cardify(isFaceUp: card.isDealt, isSelected: card.isSelected, isMatched: card.isMatched)
            .aspectRatio(0.75, contentMode: .fit)
        
    }

}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SetGameViewModel()
        return SetGameView(viewModel: viewModel)
    }
}
