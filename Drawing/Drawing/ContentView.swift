//
//  ContentView.swift
//  Drawing
//
//  Created by Nurbergen Yeleshov on 06.04.2021.
//

import SwiftUI


struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: 0, y: rect.midY))
        
        
        return path
    }
}

struct ContentView: View {
    @State private var thickness: CGFloat = 3
    
    
    var body: some View {
        VStack {
            Arrow()
               .stroke(Color.red, style: StrokeStyle(lineCap: .round, lineJoin: .round))
               .frame(width: 300, height: 200)
            
            withAnimation(.linear(duration: 1)) {
                Button("Animate") {
                    thickness = 10 - thickness
                }
            }
            Slider(value: $thickness, in: 1...10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
