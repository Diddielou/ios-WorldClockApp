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
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    @State var viewModel: WorldClockAppViewModel
    var indexOfClock: Int
    
    init(viewModel : WorldClockAppViewModel, indexOfClock: Int){ // TODO: indexOfClock kommt rein und setzen
        self.viewModel = viewModel
        self.indexOfClock = indexOfClock
    }
    
    
    
    
    @ViewBuilder
    var body: some View {
     GeometryReader { geometry in
    
      let size = geometry.size // TODO: size replace
      // TODO: iPad: Skalierbarkeit
         let minSize = min(size.width, size.height)/2-min(size.width, size.height)/20 // .frame(width: screenSize.width, height: screenSize.height-50)
     // minSize: radius: Hälfte von Width von Device
        // print(minSize);
      
      var angleArray = self.viewModel.getAngles(currentClock: viewModel.clocks[0]) // TODO: mit indexOfClock ersetzen
      let animation = Animation.linear(duration: 0.01)
    
        HStack {
            ZStack {
                ForEach(0..<4) { tick in
                    VStack {
                        // quarter hour
                        Rectangle()
                            .fill(Color.primary)
                            .frame(width: minSize/20, height: minSize/6)
                            .offset(y: minSize-minSize/12) // iPad: -20, iPhone: minSize-minSize/10 TODO: richtige Sizes 25 länge von tick, durch 2 und noch ein bisschen mehr
                    }
                    .rotationEffect(Angle.degrees(Double(tick)/4*360))
                }
                ForEach(0..<12) { tick in
                    VStack {
                        // each hour
                        Rectangle()
                            .fill(Color.primary)
                            .frame(width: minSize/30, height: minSize/10) // (width: 5, height: 20)
                            .offset(y: minSize-9)
                        //Spacer()
                    }
                    .rotationEffect(Angle.degrees(Double(tick)/12*360))
                }
                ForEach(0..<60) { tick in
                    VStack {
                        Rectangle()
                            .fill(Color.primary)
                            .frame(width: minSize/60, height: minSize/12) // width: 2, height: 15)
                            .offset(y: minSize-8)
                    }
                    .rotationEffect(Angle.degrees(Double(tick)/60*360))
                }
                Color.clear
                
                Hand(length: minSize*1.6) // HourHand TODO: check
                    .stroke(Color.primary, lineWidth: minSize/20) // TODO: lineWidths
                    .rotationEffect(Angle.degrees(angleArray[0]))
                
                Hand(length: minSize*1.4) // MinuteHand
                    .stroke(Color.primary, lineWidth: minSize/50)
                    .rotationEffect(Angle.degrees(angleArray[1]))
                
                Hand(length: minSize*1.4) // SecondHand
                    .stroke(Color.red, lineWidth: minSize/60)
                    .rotationEffect(Angle.degrees(angleArray[2]))
                    
            }// Zstack end
            .onReceive(viewModel.timer) { (_) in
                    viewModel = WorldClockAppViewModel()
                    withAnimation(animation){
                        angleArray = viewModel.getAngles(currentClock: viewModel.clocks[indexOfClock]) // TODO: Automatize
                    }
            }
            
            //Spacer()
            
                //.frame(width: size.width, height: size.height/8, alignment: .bottom)
                // TODO: wieso ist frame so klein, obwohl ClockView-Child so viel Platz hätte? (siehe View)
        } // end VStack
            } // end Geometry
              //.aspectRatio(1, contentMode: .fit)
              //.frame(width: screenSize.width, height: screenSize.height-50)
              
    } // end body
} // end Clockview


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
            WorldClockAppView(viewModel: WorldClockAppViewModel())
        }
    }

