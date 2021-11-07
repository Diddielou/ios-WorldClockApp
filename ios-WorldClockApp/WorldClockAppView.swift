import SwiftUI

struct WorldClockAppView: View {
    
    @ObservedObject var viewModel: WorldClockAppViewModel
    
    var body: some View {
        createOverview()
    }
    
    
    func createOverview() -> some View {
        NavigationView {
            List {
                ForEach (viewModel.clocks){ clock in
                    NavigationLink(destination: createDetailView(currentClock: clock)) {
                        HStack {
                            ClockView(viewModel: viewModel, currentClock: clock)
                                .frame(width: 125, height: 125)
                            Spacer()
                            Text(viewModel.getCity(currentClock: clock))
                        }
                    }
                }.navigationTitle("World Clock App")
            }
        }
    }
    
    func createDetailView(currentClock: WorldClockAppModel.Clock) -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            let minSize = min(size.width, size.height)
            
            if UIDevice.current.orientation.isLandscape {
                HStack {
                    getStack(viewModel: viewModel, currentClock: currentClock, size: size, minSize: minSize)
                }
            } else {
                VStack {
                    getStack(viewModel: viewModel, currentClock: currentClock, size: size, minSize: minSize)
                }
            }
        }
    }
    
    func getStack(
        viewModel: WorldClockAppViewModel,
        currentClock: WorldClockAppModel.Clock,
        size: CGSize,
        minSize: CGFloat) -> some View {
        Group {
            Spacer()
            ClockView(viewModel: viewModel, currentClock: currentClock)
                .frame(width: minSize, height: minSize)
            Spacer()
            Text(viewModel.getCity(currentClock: currentClock))
                .font(Font.system(size: fontSize(for: size)))
            Spacer()
        }
    }
    
    func fontSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height) / 10
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockAppView(viewModel: WorldClockAppViewModel())
    }
}
