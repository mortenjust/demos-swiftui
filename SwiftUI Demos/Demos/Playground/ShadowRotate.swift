//
//  ShadowRotate.swift
//  SwiftUI Demos
//
//  Created by Morten Just on 1/17/23.
//

import SwiftUI

struct ShadowRotate: View {
    @State var f: CGFloat = 1.0
    
    let baseColor = Color(white: 0.8)
    let foreColor = Color.white
    
    func TheView() -> some View {
        Text("R").font(.system(size: 200, weight: .black))
    }
    
    var body: some View {
        let sc = Color.black.opacity(0.5)
        ZStack {
            
            
            TheView()
                .foregroundStyle(
                    foreColor
                    .shadow(
                        .drop(color: sc,
                              radius: 4, x:  -3, y: 20))
                )
                .mask (
                    LinearGradient(stops: [
                        .init(color: .clear, location: 0.5),
                        .init(color: .black, location: 1)
                    ],
                                   startPoint: .top,
                                   endPoint: .bottom)
                    )
                .rotation3DEffect(.degrees(30),
                                  axis: (x: 1, y: 0, z: 0))
            
            TheView()
                .foregroundStyle(
                    foreColor
                    .shadow(
                        .drop(color: sc,
                              radius: 4, x:  -3, y: 20))
                )
                .mask (
                    LinearGradient(stops: [
                        .init(color: .clear, location: 0.5),
                        .init(color: .black, location: 1)
                    ],
                                   startPoint: .top,
                                   endPoint: .bottom)
                    )
                .rotation3DEffect(.degrees(45),
                                  axis: (x: 1, y: 0, z: 0))
            TheView()
                .foregroundStyle(
                    foreColor
                    .shadow(
                        .inner(color: sc,
                               radius: 4, x: -3, y: 20)))
                .mask (
                    LinearGradient(stops: [
                        .init(color: .black, location: 0.0),
                        .init(color: .clear, location: 0.7),
                    ],
                                   startPoint: .top, endPoint: .bottom)
                )

                .rotation3DEffect(.degrees(30),
                                  axis: (x: 1, y: 0, z: 0))
            TheView()

                .foregroundStyle(
                    foreColor
                    .shadow(
                        .inner(color: sc,
                               radius: 4, x: -3, y: 20)))
                .mask (
                    LinearGradient(stops: [
                        .init(color: .black, location: 0.0),
                        .init(color: .clear, location: 0.7),
                    ],
                                   startPoint: .top, endPoint: .bottom)
                )
                .rotation3DEffect(.degrees(40),
                                  axis: (x: 1, y: 0, z: 0))
        }
        .padding(150)
        .ignoresSafeArea()
        .background(baseColor)
            
    }
}

struct ShadowRotate_Previews: PreviewProvider {
    static var previews: some View {
        ShadowRotate()
            .frame(width: 500, height: 500)
    }
}
