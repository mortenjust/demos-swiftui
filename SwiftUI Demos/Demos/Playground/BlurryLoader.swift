//
//  LinearLike.swift
//  SwiftUI Demos
//
//  Created by Morten Just on 1/17/23.
//

import SwiftUI



struct BlurryLoader: View {
    @State var f = 0.0
    
    var body: some View {
        let s = (Int(1)...Int(20)).map {
            Color(hue: (Double($0) * 0.01), saturation: 2, brightness: 0.7)
        }
        let g = AngularGradient(colors: [.pink, .blue, .purple], center: .center,
                                startAngle: .degrees(0), endAngle: .degrees(f * (360 * 2)))
        ZStack {
            HStack(spacing:0) {
                g
//                g.scaleEffect(x: -1)
            }
//            .saturation(0.1)
            .blur(radius: 100)
            .brightness(-0.1)
            .saturation(0.5)
            
            Text("")
                .font(.system(size: 100).bold())
                .kerning(-0.5)
                .multilineTextAlignment(.center)
                .blendMode(.screen)
//                .offset(y: 80)
        }

        .onAppear {
            withAnimation(
                .easeInOut(duration: 10)
                .repeatForever(autoreverses: true)
            ) {
                f = 1
            }
        }
    }
}

struct BlurryLoader_Previews: PreviewProvider {
    static var previews: some View {
        BlurryLoader()
//            .frame(width: 500, height: 500)
    }
}
