//
//  WorldClockAppViewModel.swift
//  ios-WorldClockApp
//
//  Created by Katrin Stutz on 03.10.21.
//

import Foundation

class WorldClockAppViewModel: ObservableObject {
    
    @Published private var model : WorldClockAppModel
    
    // TODO: Zeit holen von Model und Timer registrieren
    // var timer = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    init(){
        model = WorldClockAppViewModel.createModel()
        print(model.currentTime)
    }
    
    // timeZone wird hier mitgegeben
    static func createModel() -> WorldClockAppModel {
        return WorldClockAppModel(timeZone: "Europe/Zurich")
    }
    
    // TODO: korrekte Art die Zeit in die View zu holen?
    
    
    func getAngles() -> Array<Double> {
        // let angleOffset = -Double.pi / 2 // - pi/2 radians means 90 degrees
        let currentHour = Double(model.currentTime.hour)
        let currentMinute = Double(model.currentTime.minute)
        let currentSecond = Double(model.currentTime.second)
        
        var output : Array<Double> = Array()
        
        let fractionalHour = (currentHour.truncatingRemainder(dividingBy: 12)) + currentMinute / 60 + currentSecond / 3600
        print("fractionalHour: ")
        print(fractionalHour)
        let fractionalMinute = currentMinute + currentSecond / 60
        print("fractionalMinute: ")
        print(fractionalMinute)
        let fractionalSecond = currentSecond
        print("fractionalSecond: ")
        print(fractionalSecond)
        
        var angleHour : Double
        var angleMinute : Double
        var angleSecond : Double
        
        //another try
        let hourDegrees = 360.0 / 12.0
        let minuteDegrees = 360.0 / 60.0
        let secondDegrees = 360.0 / 60.0
        
        angleHour = hourDegrees * fractionalHour // degsToRads(hourDegrees) * fractionalHour + angleOffset
        print("angleHour: ")
        print(angleHour)
        angleMinute = minuteDegrees * fractionalMinute // degsToRads(minuteDegrees) * fractionalMinute + angleOffset
        print("angleMinute: ")
        print(angleMinute)
        angleSecond =  secondDegrees * fractionalSecond// degsToRads(secondDegrees) * fractionalSecond + angleOffset
        print("angleSecond: ")
        print(angleSecond)
        
        output.insert(angleHour, at: 0)
        output.insert(angleMinute, at: 1)
        output.insert(angleSecond, at: 2)
        
        return output
    }
    
    
    
}
    /*
     
     func getTime() -> WorldClockAppModel.Time {
         return model.currentTime
     }
    func getHour() -> Int {
        return model.currentTime.hour
    }
    func getMinute() -> Int {
        return model.currentTime.minute
    }
    func getSecond() -> Int {
        return model.currentTime.second
    }
     */
    
    /*
     .onReceive(receiver) { (_) in
       let calender = Calendar.current
                              
       let min = calender.component(.minute, from: Date())
       let sec = calender.component(.second, from: Date())
       let hour = calender.component(.hour, from: Date())
                         
       withAnimation(Animation.linear(duration: 0.01)) {
        self.current_Time = Time(min: min, sec: sec, hour: hour)
       }
      }
     */

    
    
    
        
    
    /*
    func transform(value: Double) -> Double{
        return value * Double.pi/180.0
    }
    func degsToRads(_ degrees: Double) -> Double {
        return 2 * Double.pi * degrees / 360
    }
     */


   
