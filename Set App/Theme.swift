import SwiftUI

struct Theme {
    var shadings: [Double]
    var colors: [Color]
    var numbers: [Int]
    var shapes: [AnyShape]
    
    func getContent(features: [Int]) -> some View {
        let shading = shadings[features[0]]
        let color = colors[features[1]]
        let number = numbers[features[2]]
        let shape = shapes[features[3]]
        
        return (
            VStack {
                ForEach(0..<number) {_ in
                    ZStack {
                        shape.scale(1.3).stroke(color, lineWidth: 2)
                        shape.scale(1.3).fill(color).opacity(shading)
                    }
                    .padding(2)
                    .aspectRatio(3, contentMode: .fit)
                }
            }
        )
    }
}

struct AnyShape: Shape {
    private let builder: (CGRect) -> Path
    
    init<S: Shape>(_ shape: S) {
        builder = { rect in
            let path = shape.path(in: rect)
            return path
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return builder(rect)
    }
    
    
}

struct Theme_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
