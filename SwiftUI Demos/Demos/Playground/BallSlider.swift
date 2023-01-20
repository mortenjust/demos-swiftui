//
//  BallSlider.swift
//  SwiftUI Demos
//
//  Created by Morten Just on 1/16/23.
//

import SwiftUI

struct BallSlider: View {
    
    @State var f : Double = 0.7
    let anim = Animation.linear(duration: 5)
        .repeatForever(autoreverses: true)
    
    var body: some View {
        let fd = f * 2
        
        GeometryReader { reader in
            
            
            
            ZStack {
                Circle()
                    .fill(Color.blue)
                
                ZStack {
                    Rectangle()
                        .fill(Color.red)
                        .offset(x: reader.size.width * 0.5)
                    
                        Capsule()
                            .fill(Color.red)
                            .scaleEffect(x: 1 - fd, y: 1.0)
                        // fully red at 1, half red at 0
                    
                        Capsule()
                            .fill(Color.green)
                            .scaleEffect(x: (1 - fd), y: 1.0)

                    // fd is fully green at 1, half green at 0
                }
                
                
                
            }
        }
        .mask { Circle() }
        
        HStack {
            Slider(value: $f)
            Text("\(f)")
        }
        
    }
    
    
    
}

struct BallSlider_Previews: PreviewProvider {
    static var previews: some View {
        BallSlider()
            .frame(width: 600, height: 600)
    }
}



//struct AdjustableCapsule : Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//    }
//}


extension FloatingPoint {
  /// Allows mapping between reverse ranges, which are illegal to construct (e.g. `10..<0`).
  func interpolated(
    fromLowerBound: Self,
    fromUpperBound: Self,
    toLowerBound: Self,
    toUpperBound: Self) -> Self
  {
    let positionInRange = (self - fromLowerBound) / (fromUpperBound - fromLowerBound)
    return (positionInRange * (toUpperBound - toLowerBound)) + toLowerBound
  }

  func interpolated(from: ClosedRange<Self>, to: ClosedRange<Self>) -> Self {
    interpolated(
      fromLowerBound: from.lowerBound,
      fromUpperBound: from.upperBound,
      toLowerBound: to.lowerBound,
      toUpperBound: to.upperBound)
  }
}
