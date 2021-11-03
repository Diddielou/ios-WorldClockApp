import SwiftUI

// TODO: ClockView: enum wird momentan nicht gebraucht (können nicht auf Variablen zugreifen). Definition von enum falsch? Wie sollte man enum brauchen? -> inkl. letzter Punkt A2: width, height, color in einem Parameter?

// TODO: ClockView: A4: Skalierbarkeit einer View: Clockface-Size Werte für einzelne Shapes sind fix > falsch.
// TODO: A4: Ramona fragen wegen GeometryReader (Scalability)

struct WorldClockAppView: View {
    
   let screenSize: CGRect = UIScreen.main.bounds
   @ObservedObject var viewModel: WorldClockAppViewModel
    
    // TODO: A5: WorldClockAppView: Liste erstellen mit ClockViews, gem. Time-Liste im ViewModel (gem. Memory)
    
   var body: some View {
       
       /*
        Pseudo-Code
        Foreach timezone-name/city in ViewModel
        create a ClockView with city in Parameter
        ! pass index of clocks[] from View to ClockView
        ???
        
        Array of clocks (Array wird in ViewModel erstellt. Clocks sind aus Model) mit ClockView aufrufen...
        */
       
       
       /*
       NavigationView {
           List {
               Row() Iterieren über viewModel.times
           }
           
           .navigationTitle("World Clock App")
       }
        */
    
       ClockView(viewModel: viewModel) // TODO: indexOfClock mitgeben
       
               //.aspectRatio(1, contentMode: .fit)
               //.frame(width: screenSize.width, height: screenSize.height-50)
        }
        //.frame(alignment: .center)
        //.frame(minWidth: .infinity, maxWidth: .infinity)
        //.frame(width: screenSize.width*0.7, height: screenSize.height*0.7)
}

/*
struct Row: View {
    
    var body : some View {
        
        HStack {
            ClockView(viewModel: viewModel)
                .frame(width: 50, height: 50)
            Spacer()
            Text("Zürich").frame(alignment: .leading)
        }
    }
}
 */

// View : DetailView

// wenn du quer bist, mach es nebenenan oder übereinander
// UIDevice.current.orientation.landscape / portrait
// 1 Uhr mit Text Spacer


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            WorldClockAppView(viewModel: WorldClockAppViewModel())
        }
    }
