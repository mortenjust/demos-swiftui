//
//  Line.swift
//  CircleAnimation
//
//  Created by Morten Just on 1/15/23.
//

import SwiftUI

struct LineGradient: View {
    @State var offset : CGFloat = 0
    @State var go = false
    
    var body: some View {
        
        let linear = LinearGradient(
            colors: [.red, .orange, .green, .blue, .orange, .red], startPoint: .leading, endPoint: .trailing)
        
        let smooth = Gradient(stops: [.init(color: .white, location: 0.0),
                                      .init(color: .clear, location: 0.8),
                                      
        ])
        let ellip = EllipticalGradient(gradient: smooth)
//
        
        let _ = Self._printChanges()
        
        
        GeometryReader { reader in
            
            ZStack {
                Group {
                Rectangle()
                    .fill(linear)
                    .frame(height: 50)
                    .blur(radius: 5)
                Rectangle()
                    .fill(.white)
                    .frame(height: 20)
                    .blendMode(.plusLighter)
                    .blur(radius: 5)
                }
                Ellipse()
                    .fill(ellip)
                    .frame(width: 400, height: 100)
                    
                    .offset(x: go ? (reader.size.width * 0.5) : -(reader.size.width * 0.3))
                    .blur(radius: 20)
                    .blendMode(.plusLighter)
//                    .blendMode(.screen)
                
                    
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 5)
                            .repeatForever(autoreverses: true )) {
                            go = true
                        }
                    }
                    
                
                
            }.frame(height: 500)
                .drawingGroup()
            
        }
    }
    
    
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        LineGradient()
    }
}
