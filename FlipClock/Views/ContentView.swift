import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 50.0) {
            ClockView(config: FlipTextViewConfig(fontSize: 50.0))
            ClockView(viewModel: ClockViewModel(animationDuration: 0.66),
                isTextBased: false, imageScale: 0.5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
