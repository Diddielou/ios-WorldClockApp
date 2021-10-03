import SwiftUI


struct WorldClockAppView: View {
    var body: some View {
    ClockFace()
    }
}


struct ClockFace: View {
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            ForEach(0..<4) { tick in
                VStack {
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 6, height: 25)
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick)/4*360))
            }
            ForEach(0..<12) { tick in
                VStack {
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 5, height: 20)
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick)/12*360))
            }
            ForEach(0..<60) { tick in
                VStack {
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 3, height: 15)
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick)/60*360))
            }
            Color.clear
        }
        // adjust clock size here
        .frame(width: screenSize.width*40/100, height: screenSize.height*40/100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockAppView()
 
    }
}
