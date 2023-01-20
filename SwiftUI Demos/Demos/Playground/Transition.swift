//
//  Transition.swift
//  SwiftUI Demos
//
//  Created by Morten Just on 1/18/23.
//

import SwiftUI

struct Transition: View {
    let go : Bool
    
    var body: some View {
        VStack {
            if go {
                Text("Hello, World!")
                    .transition(.move(edge: .bottom)
                        .combined(with: .scale(scale: 0.89, anchor: .leading))
                        .combined(with: .opacity))
                   
                    .clipped()
                   
            } else {
                Circle()
                    .opacity(0.1)
                    
            }
            
        }
        
        .animation(.linear(duration: 10), value: go)
    }
}

struct Transition_Previews: PreviewProvider {
    static var previews: some View {
        Transition(go: true)
    }
}
