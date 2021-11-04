import Foundation
import SwiftUI

class WorldClockAppViewModel: ObservableObject {
    
    @Published private var model : WorldClockAppModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(){
        model = WorldClockAppViewModel.createModel()
    }
    
    static func createModel() -> WorldClockAppModel { // TODO: fill with 12 different time zones (for each time zone one)
        let cities: Array<String> = [
            "Europe/Zurich",
            "Europe/Moscow",
            "America/Los_Angeles",
            "America/Miquelon",
            "America/Port-au-Prince",
            "Atlantic/Bermuda",
            "Asia/Dubai",
            "Asia/Jerusalem",
            "Asia/Pyongyang",
            "Asia/Singapore",
            "Australia/Eucla",
            "Pacific/Fiji"] // MARK: what to do when Timezone isn't found? maybe bonus?
        return WorldClockAppModel(numberOfClocks: cities.count, clockContentFactory: {
            index in
            return cities[index]
        })
    }
    
    var clocks : [WorldClockAppModel.Clock] {
        model.clocks
    }
    
    func getCity(currentClock: WorldClockAppModel.Clock) -> String {
        let timeZone = currentClock.timeZone
        var cityString: String = ""
        if let range = timeZone.range(of: "/") {
            let citySubstring : Substring = timeZone[range.upperBound...]
            cityString = String(citySubstring).replacingOccurrences(of: "_", with: " ") // MARK: replaces _ (Los_Angeles) with Space
        }
        return cityString
    }
    
    func getAngles(indexOfClock : Int) -> Array<Double> {
        
        let currentHour = Double(clocks[indexOfClock].currentTime.hour)
        let currentMinute = Double(clocks[indexOfClock].currentTime.minute)
        let currentSecond = Double(clocks[indexOfClock].currentTime.second)
        
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
