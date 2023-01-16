//
//  FlowerView.swift
//  CircleAnimation
//
//  Created by Morten Just on 1/15/23.
//

import SwiftUI

struct FlowerView: View {
    @State var go = true
    @State var size : CGSize = .zero
    @State var deg  = 0.0
    @State var ax = 0.0
    @State var ay = 0.0
    @State var az = 0.0
    
    var body: some View {
        let anim = Animation.easeInOut(duration: 3)
            .repeatForever(autoreverses: true)
            .repeatForever(autoreverses: true)
        let hue = 0.7
        VStack {
            ZStack {
                ForEach(0..<10) { i in
                    let d = Double(i)
                    let s = go ? 30.0 : 0
                    let f = d * 0.1
                    let c = Color(hue: hue,
                                  saturation: 1 - f,
                                  brightness: d * 0.1)
                    let dc = Color(hue: hue, saturation: 0.5, brightness: f - 0.5)
                    
                    Rectangle()
                        .fill(c)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(go ? size.width * 0.1 : size.width )
                        .scaleEffect(1 - f)
                        .rotationEffect(go ? .degrees(d * 10) : Angle.degrees(0))
                        .shadow(color: dc, radius: s, x: s, y: s)
                }
                .onAppear {
                    withAnimation(anim) {
                        go.toggle()
                    }
                }
            }
            
            .rotation3DEffect(.degrees(deg * 100), axis: (x: ax, y: ay, z: az))
            .overlay { GeometryReader { r in
                Rectangle().fill(Color.clear).onAppear { size = r.size }
            }}
            .compositingGroup()
            HStack {
                Slider(value: $deg)
                Slider(value: $ax)
                Slider(value: $ay)
                Slider(value: $az)
                
            }
        }
        .edgesIgnoringSafeArea([.all])
            .background(Color.black)
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}




import Foundation
import WebKit

struct YouTubeView: NSViewRepresentable {
    let videoId: String
    func makeNSView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    func updateNSView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: "https://www.youtube.com/embed/\(videoId)?autoplay=true") else { return }
//        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}
