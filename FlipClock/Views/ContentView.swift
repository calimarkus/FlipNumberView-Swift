import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            ClockView(config: FlipTextViewConfig(fontSize: 50.0))
            Spacer().frame(height: 40.0)
            ClockView(isTextBased: false)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

