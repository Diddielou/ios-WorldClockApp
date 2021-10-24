//
//  WorldClockAppViewModel.swift
//  ios-WorldClockApp
//
//  Created by Katrin Stutz on 03.10.21.
//

import Foundation

class WorldClockAppViewModel: ObservableObject {
    
    @Published private var model : WorldClockAppModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(){
        model = WorldClockAppViewModel.createModel()
        print(model.currentTime)
    }
    
    static func createModel() -> WorldClockAppModel {
        return WorldClockAppModel(timeZone: "Europe/Zurich")
    }
    
    func updateModel() {
        self.model = WorldClockAppModel(timeZone: "Europe/Zurich")
    }
    
    func getAngles() -> Array<Double> {
        // let angleOffset = -Double.pi / 2 // - pi/2 radians means 90 degrees
        let currentHour = Double(model.currentTime.hour)
        let currentMinute = Double(model.currentTime.minute)
        let currentSecond = Double(model.currentTime.second)
        
        var output : Array<Double> = Array()
        
        let fractionalHour = (currentHour.truncatingRemainder(dividingBy: 12)) + currentMinute / 60 + currentSecond / 3600
        let fractionalMinute = currentMinute + currentSecond / 60
        let fractionalSecond = currentSecond
        
        var angleHour : Double
        var angleMinute : Double
        var angleSecond : Double
        
        //another try
        let hourDegrees = 360.0 / 12.0
        let minuteDegrees = 360.0 / 60.0
        let secondDegrees = 360.0 / 60.0
        
        angleHour = hourDegrees * fractionalHour
        angleMinute = minuteDegrees * fractionalMinute
        angleSecond =  secondDegrees * fractionalSecond
        
        output.insert(angleHour, at: 0)
        output.insert(angleMinute, at: 1)
        output.insert(angleSecond, at: 2)
        
        return output
    }
    
    
}
