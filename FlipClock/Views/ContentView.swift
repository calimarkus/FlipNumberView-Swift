import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10.0) {
            Spacer()

            Text("Text based:").foregroundColor(.black)
            ClockView(config: FlipTextViewConfig(fontSize: 50.0))
            Spacer().frame(height: 10.0)
            Text("Image based:").foregroundColor(.black)
            ClockView(viewModel: ClockViewModel(animationDuration: 0.66),
                isTextBased: false, imageScale: 0.6)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
