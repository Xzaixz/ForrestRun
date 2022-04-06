//
//  ContentView.swift
//  ForrestTimer
//
//  Created by Михаил  Галицкий on 06.04.2022.
//

import SwiftUI

struct Data: Identifiable {
    let id = UUID()
    var time: String
}

struct ContentView: View {
    @State var timeRemaining = 0.0
    @State var startTimer = false
    @State var stopTimes: [String] = []
    @State var laps = 0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    private let values: [Data] = [
        Data(time: "0.00")
    ]
    
    var body: some View {
        
        ZStack{
            Image("lnchScreen").ignoresSafeArea()
            Color("Color").ignoresSafeArea().opacity(0.6)
            
            VStack{
                Spacer()
                Text(String(format: "%.2f", timeRemaining)).onReceive(timer){ _ in
                    if (timeRemaining >= 0 && startTimer == true){
                        timeRemaining += 0.01
                    }
                }
                .frame(width: 200, height: 50).font(.system(size: 30)).padding(.bottom).foregroundColor(.white)
                
                VStack{
                    HStack{
                        Button(action: {
                            if (startTimer == false && timeRemaining != 0.0){
                                timeRemaining = 0.0
                                startTimer = false
                                laps = 0
                                stopTimes = []
                            }
                            else {
                                if (laps >= 0 && startTimer == true){
                                    stopTimes.append(String(format: "%.2f", timeRemaining))
                                    laps += 1
                                }
                            }
                        })
                        {
                            if (startTimer == false && timeRemaining != 0.0){
                                HStack{
                                    Text("Reset").padding(.trailing, 50).foregroundColor(.white)
                                }
                            }
                            else {
                                HStack{
                                    Text("Lap").padding(.trailing, 50).foregroundColor(.white)
                                }
                            }
                            
                        }
                        Button(action: {
                            startTimer.toggle()
                        }){
                            if startTimer == true {
                                HStack{
                                    Text("Pause").foregroundColor(.white)
                                }
                            }
                            else {
                                Text("Start").foregroundColor(.white)
                            }
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            ScrollView(showsIndicators: false){
                VStack(spacing: 15){
                    ForEach(stopTimes, id: \.self){
                        stopTimes in Text(stopTimes)
                        if laps != 0 {
                            Rectangle().fill(.black).frame(width: 300, height: 1).opacity(0.5)
                        }
                    }
                    Spacer()
                }
                .foregroundColor(.white).font(.system(size: 20))
            }
            .frame(width: 300, height: 500).offset(y: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
