//
//  Circle.swift
//  CircleAnimation
//
//  Created by Morten Just on 1/15/23.
//

import SwiftUI

struct CircleGradient: View {
    
    @State var move = false
    
    var body: some View {
    
        let angular = AngularGradient(
            colors: [.red, .orange, .green, .blue, .orange, .red], center: .center, startAngle: .degrees(0), endAngle: .degrees(360))
        
        let ellip = EllipticalGradient(
            colors: [Color(.sRGBLinear, white: 1, opacity: 1), .clear],
            startRadiusFraction: 0,
            endRadiusFraction: 0.2)
        ZStack {
            Group {
                
                Circle()
                    .stroke(angular, lineWidth: 30)
                    .frame(width: 300, height: 300)
                    .blur(radius: 10)
                    .padding(40)
                Circle()
                    .stroke(Color.white, lineWidth: 10)
                    .frame(width: 300, height: 300)
                    .padding(40)
                    .blur(radius: 4)
                    .blendMode(.colorDodge)
            }
            
            ZStack {
                Ellipse()
                    .fill(ellip)
                    .frame(width: 300, height: 200)
                    .blur(radius: 10)
                
                Ellipse()
                    .fill(ellip)
                    .frame(width: 10, height: 300)
                    .blur(radius: 5)
            }
            .blendMode(.colorDodge)
            .compositingGroup()
            .offset(y: 150)
            .rotationEffect(.degrees(move ? -360 : 0))
                
                
        }
        .rotationEffect(.degrees(move ? -360 : 0))
        .ignoresSafeArea()
        .drawingGroup()
        .padding()
        .onTapGesture {
            withAnimation(
                .linear(duration: 10)
                .repeatForever(autoreverses: false)) {
                move.toggle()
            }
        }
    }
}

struct Circle_Previews: PreviewProvider {
    static var previews: some View {
        CircleGradient()
    }
}
