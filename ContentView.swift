import SwiftUI


struct Line {
    var points = [CGPoint]()
    var color: Color = .red
    var lineWidth: Double = 1.0
}


struct ContentView: View {
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var selectedColor: Color = .red
    
    var body: some View {
        VStack {
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
            }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    self.lines.append(currentLine)
                })
                .onEnded({Value in
                    self.lines.append(currentLine)
                    self.currentLine = Line(points: [], color: selectedColor)
                })
            )
            
            ColorPickerView(selectedColor: $selectedColor).onChange(of: selectedColor){ newColor in
                currentLine.color = newColor
            }
            
        }.frame(minWidth: 400, minHeight: 400)
            .padding()
    }
}
