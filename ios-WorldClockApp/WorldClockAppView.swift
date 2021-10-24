import SwiftUI

// TODO: ClockView: enum wird momentan nicht gebraucht (können nicht auf Variablen zugreifen). Definition von enum falsch? Wie sollte man enum brauchen? -> inkl. letzter Punkt A2: width, height, color in einem Parameter?

// TODO: ClockView: A4: Skalierbarkeit einer View: Clockface-Size Werte für einzelne Shapes sind fix > falsch.
// TODO: A4: Fragen wegen GeometryReader (Scalability)

struct WorldClockAppView: View {
    
   let screenSize: CGRect = UIScreen.main.bounds

   var body: some View {
       
       // TODO: A5: WorldClockAppView: Liste erstellen mit allen ClockViews (gem. Memory)
        
         ClockView()
               .aspectRatio(1, contentMode: .fit)
               .frame(width: screenSize.width, height: screenSize.height-50)
        }
        //.frame(alignment: .center)
        //.frame(minWidth: .infinity, maxWidth: .infinity)
        //.frame(width: screenSize.width*0.7, height: screenSize.height*0.7)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            WorldClockAppView()
        }
    }
