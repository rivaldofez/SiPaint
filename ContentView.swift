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
    @State private var thickness: Double = 0.0
    
    var body: some View {
        VStack {
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
            }.frame(minWidth: 400, minHeight: 400)
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    self.lines.append(currentLine)
                })
                .onEnded({Value in
                    self.lines.append(currentLine)
                    self.currentLine = Line(points: [], color: selectedColor, lineWidth: thickness)
                })
                )
            
            HStack {
                Text("Thickness")
                    .font(.system(size: 16))
                
                Slider(value: $thickness, in: 1...20){
                }.frame(maxWidth: 100)
                    .onChange(of: thickness){newThickness in
                        currentLine.lineWidth = newThickness
                    }
                Divider()
                ColorPickerView(selectedColor: $selectedColor).onChange(of: selectedColor){ newColor in
                    currentLine.color = newColor
                }
                Divider()
                Button("Clear"){
                    self.lines = []
                    self.currentLine = Line(points: [], color: selectedColor, lineWidth: thickness)
                }
            }.frame(maxHeight: 100)
        }.padding()
    }
}
