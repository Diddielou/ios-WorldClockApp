import SwiftUI

/** View for one clock **/
struct ClockView : View {
    
    let screenSize: CGRect = UIScreen.main.bounds
    @State var viewModel: WorldClockAppViewModel
    var currentClock: WorldClockAppModel.Clock
    
    init(viewModel : WorldClockAppViewModel, currentClock: WorldClockAppModel.Clock){
        self.viewModel = viewModel
        self.currentClock = currentClock
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            
            let size = geometry.size
            let min = min(size.width, size.height)
            let minSize = min/2*0.90
            
            var angleArray = self.viewModel.getAngles(indexOfClock: currentClock.id)
            let animation = Animation.linear(duration: 0.01)
            
            // inspired by https://talk.objc.io/episodes/S01E192-analog-clock
            HStack {
                ZStack {
                    ForEach(0..<4) { tick in
                        VStack {
                            // quarter hour
                            Rectangle()
                                .fill(Color.primary)
                                .frame(width: minSize/23, height: minSize/7)
                                .offset(y: minSize-minSize/14) // MARK: offset abhängig von height ab: doppeltes von height/_
                        }
                        .rotationEffect(Angle.degrees(Double(tick)/4*360))
                    }
                    ForEach(0..<12) { tick in
                        VStack {
                            // each hour
                            Rectangle()
                                .fill(Color.primary)
                                .frame(width: minSize/30, height: minSize/10)
                                .offset(y: minSize-minSize/20)
                        }
                        .rotationEffect(Angle.degrees(Double(tick)/12*360))
                    }
                    ForEach(0..<60) { tick in
                        VStack {
                            // each second
                            Rectangle()
                                .fill(Color.primary)
                                .frame(width: minSize/80, height: minSize/12)
                                .offset(y: minSize-minSize/24)
                        }
                        .rotationEffect(Angle.degrees(Double(tick)/60*360))
                    }
                    Hand(length: minSize/1.75) // HourHand
                        .stroke(Color.primary, lineWidth: minSize*0.05)
                        .rotationEffect(Angle.degrees(angleArray[0]))
                    
                    Hand(length: minSize-minSize/7) // MinuteHand
                        .stroke(Color.primary, lineWidth: minSize*0.03)
                        .rotationEffect(Angle.degrees(angleArray[1]))
                    
                    Hand(length: minSize-minSize/7) // SecondHand
                        .stroke(Color.red, lineWidth: minSize*0.015)
                        .rotationEffect(Angle.degrees(angleArray[2]))
                    
                    Circle()
                        .fill(.red)
                        .frame(width: minSize*0.08, height: minSize*0.08)
                }
                // inspired by https://github.com/tmusabe/ClockApp/blob/main/ClockApp/ClockApp/View/TimeWatchView.swift
                .onReceive(viewModel.timer) { (_) in
                    viewModel = WorldClockAppViewModel()
                    withAnimation(animation){
                        angleArray = viewModel.getAngles(indexOfClock: currentClock.id)
                    }
                }
            }
        }
    }
}

/** Anfang von allen Zeigern muss realtiv zu Clockface positioniert werden, damit alle Zeiger im Zentrum von Clockface starten. **/
extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    init(center: CGPoint, radius: CGFloat) {
        self = CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        )
    }
}

struct Hand: Shape {
    var length: CGFloat
    
    func path(in rect: CGRect) -> Path { // single hand
        let circleRadius: CGFloat = length*0.025
        return Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.midY+length))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius))
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorldClockAppView(viewModel: WorldClockAppViewModel())
        }
    }
}
