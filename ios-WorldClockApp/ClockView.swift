//
//  ClockView.swift
//  ios-WorldClockApp
//
//  Created by Dinah Bolli on 24.10.21.
//

import SwiftUI

/* // Hands (Zeiger)
public enum Hands { // case: height, case: width, case: color
    // case hourHand(hourHand: Hand(length: 50))
    case hourHand(height: CGFloat = 9, width: CGFloat = 100, color: Color = Color.primary)
    case minuteHand(height: CGFloat, width: CGFloat, color: Color)
    case secondHand(height: CGFloat, width: CGFloat, color: Color)
}
*/

/** View for one clock **/
struct ClockView : View {
    
    //let screenSize: CGRect = UIScreen.main.bounds
    @ObservedObject var viewModel: WorldClockAppViewModel
    
    init(){
        viewModel = WorldClockAppViewModel()
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body (for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        
    var angleArray = viewModel.getAngles()
    let animation = Animation.linear(duration: 0.01)
        
    // TODO: Skalierbarkeit: einzelne Werte mit GeometryReader (for: size)?
        VStack { // To put in text
            ZStack {
                ForEach(0..<4) { tick in
                    VStack {
                        // quarter hour
                        Rectangle()
                            .fill(Color.primary)
                            .frame(width: 6, height: 25)
                        Spacer()
                    }
                    .rotationEffect(Angle.degrees(Double(tick)/4*360))
                }
                ForEach(0..<12) { tick in
                    VStack {
                        // each hour
                        Rectangle()
                            .fill(Color.primary)
                            .frame(width: 5, height: 20)
                        Spacer()
                    }
                    .rotationEffect(Angle.degrees(Double(tick)/12*360))
                }
                ForEach(0..<60) { tick in
                    VStack {
                        //
                        Rectangle()
                            .fill(Color.primary)
                            .frame(width: 2, height: 15)
                        Spacer()
                    }
                    .rotationEffect(Angle.degrees(Double(tick)/60*360))
                }
                Color.clear
                
                Hand(length: 50) // HourHand
                    .stroke(Color.primary, lineWidth: 6)
                    .rotationEffect(Angle.degrees(angleArray[0]))
                
                Hand(length: 25) // MinuteHand
                    .stroke(Color.primary, lineWidth: 3)
                    .rotationEffect(Angle.degrees(angleArray[1]))
                
                Hand(length: 25) // SecondHand
                    .stroke(Color.red, lineWidth: 2)
                    .rotationEffect(Angle.degrees(angleArray[2]))
                    
                
                }.onReceive(viewModel.timer) { (_) in
                    viewModel.updateModel()
                    withAnimation(animation){
                        angleArray = viewModel.getAngles()
                    }
                
            } // Zstack end
            
            Spacer()
            Text("Zurich")
                .font(Font.system(size: fontSize(for: size)))
                //.frame(width: size.width, height: size.height/8, alignment: .bottom)
                // TODO: wieso ist frame so klein, obwohl ClockView-Child so viel Platz hätte? (siehe View)
    }
  } // end body
} // end Clockview


private func fontSize(for size: CGSize)->CGFloat{
    min(size.width, size.height) / 10
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
    
    init(length: CGFloat){
        self.length = length
    }
    
    var circleRadius: CGFloat = 3
    func path(in rect: CGRect) -> Path { // single hand
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY+length))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius)) // Hand line
            p.addEllipse(in: CGRect(center: rect.center, radius: circleRadius)) // Circle in center
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
            WorldClockAppView()
        }
    }

