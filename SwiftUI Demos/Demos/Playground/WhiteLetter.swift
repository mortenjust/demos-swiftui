//
//  BallSlider.swift
//  SwiftUI Demos
//
//  Created by Morten Just on 1/16/23.
//

import SwiftUI

struct WhiteLetter: View {
    
    @State var rad = 1.0
    let anim = Animation.linear(duration: 5)
        .repeatForever(autoreverses: true)
    
    var body: some View {
        GeometryReader { reader in
            
            ZStack {
                VStack(spacing: reader.size.height * 0.0002) {
                    Text("MILK")
                    Text("IS")
                    Text("WHITE")
                }
                .font(.system(size: reader.size.width * 0.2, weight: .black, design: .default))
                .tracking(-(reader.size.width * 0.001))
                .foregroundStyle(.white
                    .shadow(
                        .inner(color: .black.opacity(0.5), radius: rad * 6, x: rad * 2, y: rad * 9)))
                
                //                    .mask(
                //                        RadialGradient(colors: [.black, .white],
                //                                       center: .topLeading, startRadius: 0, endRadius: reader.size.width * (rad * 1))
                //                    )
                
                
                //            Rectangle()
                //                .fill(Color.white)
                //                .blur(radius: 100)
                //                .opacity(1)
                //                .offset(x: 10 + (rad * 4))
                
                
            }
            
            .compositingGroup()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(Color.white)
            .onTapGesture {
                withAnimation(anim) {
                    rad = rad == 1 ? 0 : 1
                }
            }
            .onAppear {
                withAnimation(anim) {
                    rad = 1
                }
            }
            
        }
        //        Circle()
        //            .foregroundStyle(.blue.shadow(.inner(color: .black, radius: 30)))
        
        //        GeometryReader { reader in
        //        ZStack {
        //            Circle()
        //
        //                .fill(Color.green)
        //
        //            ZStack {
        //                Rectangle()
        //                    .fill(Color.red)
        //                    .offset(x: reader.size.width * 0.5)
        //
        //                Capsule()
        //                    .fill(Color.red)
        //                //                .offset(x: 200)
        //                    .scaleEffect(x: 0.2, y: 1.0)
        //            }
        //        }
        //        .mask { Circle() }
        //        }
        
        
    }
}

struct WhiteLetter_Previews: PreviewProvider {
    static var previews: some View {
        WhiteLetter()
            .frame(width: 600, height: 600)
    }
}



//struct AdjustableCapsule : Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//    }
//}
