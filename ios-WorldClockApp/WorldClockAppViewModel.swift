//
//  WorldClockAppViewModel.swift
//  ios-WorldClockApp
//
//  Created by Katrin Stutz on 03.10.21.
//

import Foundation
import SwiftUI

class WorldClockAppViewModel: ObservableObject {
    
    // TODO: get timeZone from a... list, array, enum?
    
    @Published private var model : WorldClockAppModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(){
        model = WorldClockAppViewModel.createModel()
    }
    
    static func createModel() -> WorldClockAppModel {
        let cities: Array<String> = ["Europe/Zurich", "Europe/London"]
        return WorldClockAppModel(numberOfClocks: cities.count, clockContentFactory: {
            index in
            return cities[index]
        })
    }
    
    var clocks : [WorldClockAppModel.Clock] {
        model.clocks
    }
    
    // TODO: get timeZone per clock and cut out and return city
    //func getCity(Clock clock) -> String {
        // return TimeZone(city only) of received clock
        //return "Zürich";
    //}
    
    func getAngles(currentClock : WorldClockAppModel.Clock) -> Array<Double> {
        
        let currentHour = Double(currentClock.currentTime.hour)
        let currentMinute = Double(currentClock.currentTime.minute)
        let currentSecond = Double(currentClock.currentTime.second)
        
        var output : Array<Double> = Array()
        
        // TODO: fractionalHour is not perfect
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
