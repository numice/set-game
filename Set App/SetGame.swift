import Foundation

struct SetGame<CardContent> where CardContent: Equatable, CardContent: Sequence {
    var deck: [Card] = []
    let numberOfFeatures = 4
    var lastNotDealtIndex: Int? {
        get {
            deck.firstIndex(where: { !$0.isDealt })
        }
    }
    private var selectedIndices: [Int] {
        get {
            deck.indices.filter { deck[$0].isSelected }
        }
    }
    var isThreeCardsSelected: Bool {
        get {
            selectedIndices.count == 3
        }
    }
    
    struct Card: Identifiable, Equatable {
        var feature: [Int]
        var isMatched = false
        var isSelected = false
        var isDealt = false
        var id: Int
        
    }
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> [Int]) {
        for index in 0..<numberOfCards {
            let content = cardContentFactory(index)
            deck.append(Card(feature: content, id: index))
        }
        
        deck.shuffle()
        firstTimeDeal()
    }
    
    // TODO: combine this with deal()
    mutating func firstTimeDeal() {
        for index in 0..<12 {
            deck[index].isDealt = true
        }
    }
    
    mutating func deal() {
        // TODO: cannot deal if there are more than 15 cards shown
        if let lastNotDealtIndex = self.lastNotDealtIndex {
            if lastNotDealtIndex+3 <= deck.count {
                for index in lastNotDealtIndex..<lastNotDealtIndex+3 {
                    if index < deck.count {
                        deck[index].isDealt = true
                    }
                }
            }
        }
        
        let isMatched = self.isMatched(selectedIndices: selectedIndices)
        if isMatched {
            for index in self.selectedIndices {
                deck[index].isSelected = false
                print("card \(index) \(deck[index].isMatched)")
            }
        }
    }
    
    func isMatched(selectedIndices: [Int]) -> Bool {
        let cards = selectedIndices.map { deck[$0] }
        var result = true
        
        if cards.count == 3 {
            for index in 0..<4 {
               let featureMatched = (
                    cards[0].feature[index] == cards[1].feature[index]
                    && cards[1].feature[index] == cards[2].feature[index]
                    && cards[0].feature[index] == cards[2].feature[index]
                ) || (
                    cards[0].feature[index] != cards[1].feature[index]
                    && cards[1].feature[index] != cards[2].feature[index]
                    && cards[0].feature[index] != cards[2].feature[index]
                )
                
                result = result && featureMatched
            }
        } else {
            return false
        }
        return result
    }
    
    mutating func select(card: Card) {
        let selectedIndex = deck.firstIndex(of: card)!
        
        if self.selectedIndices.count == 3 {
            for index in self.selectedIndices {
                deck[index].isSelected = false

                print("card \(index) \(deck[index].isMatched)")
            }
        }        
        
        if !card.isMatched && card.isDealt {
            deck[selectedIndex].isSelected = !deck[selectedIndex].isSelected
            print("selected cards: \(self.selectedIndices)")
        }

        let isMatched = self.isMatched(selectedIndices: selectedIndices)
        print("matched? : \(isMatched)")
        if isMatched {
            for index in self.selectedIndices {
                deck[index].isMatched = true

                print("card \(index) \(deck[index].isMatched)")
            }
        }
        
        
    }
    
}
