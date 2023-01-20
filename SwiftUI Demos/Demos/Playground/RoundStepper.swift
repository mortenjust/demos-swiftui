//
//  LinearLike.swift
//  SwiftUI Demos
//
//  Created by Morten Just on 1/18/23.
//

import SwiftUI

struct RoundStepper: View {
    @State var bs : Double = 0
    
    func dg(_ t : Double) -> some Gesture {
        return DragGesture(minimumDistance: 0)
            .onEnded { _ in bs = 0 }
            .onChanged { _ in bs = t }
    }
    
    var body: some View {
        let f = Color(hue: 0, saturation: 0, brightness: 0.17)
        let t = Color(hue: 0, saturation: 0, brightness: 0.02)
        let g = AngularGradient(colors: [t, f], center: .center)
        
        ZStack {
            Circle().fill(.black)
            ZStack {
            HStack(spacing: 0) {
                g
                g.scaleEffect(x:-1)
            }.mask { Circle() }
            VStack(spacing: 200) {
                Image(systemName: "plus").gesture(dg(1))
                Image(systemName: "minus").gesture(dg(-1))
            }.font(.system(size: 60))
            }
            .rotation3DEffect(.degrees(bs * 20), axis: (x:1, y:0, z:0))
            
            Circle()
                .stroke(Gradient(colors: [.white.opacity(0.5), .black] ), lineWidth: 5)
            Circle()
                .stroke(Gradient(colors: [.black, .black]), lineWidth: 10)
                .scaleEffect(1.03)
                .rotationEffect(.degrees(30))
                .shadow(color: .black, radius: 30)
            Circle()
                .stroke(Gradient(colors: [.black, .white.opacity(0.4), .black]), lineWidth: 5)
                .scaleEffect(1.05)
                .rotationEffect(.degrees(30))
            Circle()
                .stroke(.black)
                .scaleEffect(1.08)
        }.padding(50)
            .animation(.interactiveSpring(), value: bs)

    }
}















struct RoundStepper_Previews: PreviewProvider {
    static var previews: some View {
        RoundStepper()
            .frame(width: 500, height:500)
    }
}
