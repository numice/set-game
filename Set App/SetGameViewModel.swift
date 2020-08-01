import SwiftUI

class SetGameViewModel: ObservableObject {
    
    @Published private var model: SetGame<[Int]>
    
    let shadings = [1, 0.5, 0]
    let colors = ["red", "blue", "yellow"]
    let numbers = [1, 2, 3]
    let shapes = ["circle", "square", "diamond"]
    
    let defaultTheme = Theme(
        shadings: [1, 0.5, 0],
        colors: [.red, .blue, .yellow],
        numbers: [1, 2, 3],
        shapes: [AnyShape(Circle()), AnyShape(Rectangle()), AnyShape(Capsule())]
    )
    
    init() {
        self.model = SetGameViewModel.createSetGame()
        self.model.firstTimeDeal()
    }
    
    private static func createSetGame() -> SetGame<[Int]> {
        
        let cardFeatures = SetGameViewModel.createCartesian(lists: [[Int]](repeating: [0, 1 ,2], count: 4))
//        let cardFeaturesTest = [[0,0,0,0], [1,1,1,1], [2,2,2,2]]
        print(cardFeatures.count)
        
        return SetGame(numberOfCards: cardFeatures.count) {
            index in cardFeatures[index]
        }
    }
    
    static func createCartesian<T>(lists: [[T]], prevComb: [T] = []) -> [[T]] {
        if lists.isEmpty {
            return [prevComb]
        }
        
        var lists = lists
        let first = lists.removeFirst()
        var result = [[T]]()
        
        for item in first {
            result += createCartesian(lists: lists, prevComb: prevComb + [item])
        }
        
        return result
    }
    
    
    var deck: [SetGame<[Int]>.Card] {
        model.deck
    }
    
    func select(card: SetGame<[Int]>.Card) {
        model.select(card: card)
    }
    
    func deal() {
        model.deal()
    }
    
    func newGame() {
        self.model = SetGameViewModel.createSetGame()
    }
}
