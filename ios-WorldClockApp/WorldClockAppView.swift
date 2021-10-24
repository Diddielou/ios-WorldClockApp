import SwiftUI

// TODO: enum wird momentan nicht gebraucht (können nicht auf Variablen zugreifen). Definition von enum falsch? Wie sollte man enum brauchen? -> inkl. letzter Punkt A2: width, height, color in einem Parameter?

// TODO: A3: All hands: calculate angles based on time and get from view model.
// TODO: A4: Skalierbarkeit einer View: Clockface-Size ist manuell definiert, ohne frame ist es nicht mehr Screen > wieso?


let screenSize: CGRect = UIScreen.main.bounds


// MARK: Hands (Zeiger)
public enum Hands { // case: height, case: width, case: color
    // case hourHand(hourHand: Hand(length: 50))
    case hourHand(height: CGFloat = 9, width: CGFloat = 100, color: Color = Color.primary)
    case minuteHand(height: CGFloat, width: CGFloat, color: Color)
    case secondHand(height: CGFloat, width: CGFloat, color: Color)
}

struct WorldClockAppView: View {
    
    @ObservedObject var viewModel: WorldClockAppViewModel
    
    var body: some View {
        
        let angleArray = viewModel.getAngles()
        let animation = Animation.linear(duration: 0.01)
        
        // Test
        //let marginLeading: CGFloat = 0
        //let marginTrailing: CGFloat = 100
        
        // TODO: A3
        //GeometryReader { geometryReader in
          //  let width = geometryReader.size.width * 0.85
          //  let height = geometryReader.size.height / 2.5
            ZStack {
                ClockFace()
                
                Hand(length: 50) // HourHand
                    .stroke(Color.primary, lineWidth: 6)
                    //.onReceive(viewModel.timer) { angle in //
                        .rotationEffect(Angle.degrees(angleArray[0]))
                    //})
                
                Hand(length: 25) // MinuteHand
                    .stroke(Color.primary, lineWidth: 3)
                    //.onReceive(viewModel.timer) { angle in
                        .rotationEffect(Angle.degrees(angleArray[1]))
                    //})
                
                Hand(length: 25) // SecondHand
                    .stroke(Color.red, lineWidth: 2)
                    //.onReceive(viewModel.timer) { angle in
                        .rotationEffect(Angle.degrees(angleArray[2]))
                    //})
                
                
            }
            // TODO: adjust clock size here, must not be manual
            //.frame(width: width, height: height)
        
            .frame(width: screenSize.width*40/100, height: screenSize.height*40/100)
        
        /*
            .onReceive(viewModel.timer) { (time) in
                withAnimation(Animation.linear(duration: 0.01)) { }
                    // TODO: what to do here?
                    .rotationEffect(Angle.degrees(angleArray[0]))
                    .rotationEffect(Angle.degrees(angleArray[1]))
                    .rotationEffect(Angle.degrees(angleArray[2]))
            }
         
         */
        //}
    
        }
    
    
    
    
    }

/*
 struct CurrentDateView : View {
     @State var newDate = Date() // unsere Time

     let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect() // times im ViewModel

     var body: some View {
         Text("\(newDate)")
             .onReceive(timer) { // wenn Timer geändert wird
                 self.newDate = Date() // sollen Zeiger sich bewegen
             }
     }
 }
 */


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
    
    var circleRadius: CGFloat = 3 // ellipse
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY+length))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius))
            p.addEllipse(in: CGRect(center: rect.center, radius: circleRadius))
        }
    }
}


// MARK: ClockFace: only ticks
struct ClockFace: View {
    
    
    /* // TODO: Skalierbarkeit mit GeometryReader?
    var body: some View {
        GeometryReader { geometry in
            self.body (for: geometry.size)
        }
    }
    func clockSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75 // fontSizeRatio
    }
    */
    
    
    // func body(for size: CGSize) -> some View {
    var body: some View {
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
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockAppView(viewModel: WorldClockAppViewModel())
    }
}
