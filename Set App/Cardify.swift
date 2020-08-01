import SwiftUI

struct Cardify: AnimatableModifier {
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    
    var rotation: Double
    var isFaceUp: Bool {
        rotation < 90
    }
    var isSelected: Bool
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    var isMatched: Bool
    
    init(isFaceUp: Bool, isSelected: Bool, isMatched: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isSelected = isSelected
        self.isMatched = isMatched
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                if isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.green, lineWidth: edgeLineWidth)
                } else  if isSelected {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.orange, lineWidth: edgeLineWidth)
                } else {
                   RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    
                }
                
               
                
                content.padding(20)
            }
            .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
//        .aspectRatio(0.75, contentMode: .fit)
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        
    }
    
    
}

extension View {
    func cardify(isFaceUp: Bool, isSelected: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected, isMatched: isMatched))
    }
}

struct Cardify_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
