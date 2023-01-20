//
//  TinyLineChart.swift
//  SwiftUI Demos
//
//  Created by Morten Just on 1/18/23.
//

import SwiftUI
import Charts


struct TimeValue {
    let time : TimeInterval
    let value : Double
}

struct TinyLineChart: View {
    let values : [TimeValue]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(values, id:\.time) { value in
                    AreaMark(x: .value("Time", value.time), y: .value("Realtime", value.value))
                }
            }.chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .foregroundStyle(.purple.gradient)
        }
    }
}

struct TinyLineChart_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        TinyLineChart(values: [.init(time: 1, value: 10), .init(time: 2, value: 20), .init(time: 3, value: 30)])
            .frame(width: 150, height: 50)
//            .onReceive(Timer.publish(every: 0.01, on: .main, in: .default).autoconnect()) { _  in
//                let lastTime = values.last?.time ?? 0
//                let newTime = lastTime + TimeInterval.random(in: 0.5...2)
//                let lastValue = values.last?.value ?? 0
//                let newValue = lastValue + Double.random(in: -10...15)
//                withAnimation {
//                    values.append(TimeValue(time: newTime, value: newValue))
//                }
//            }
    }
}
