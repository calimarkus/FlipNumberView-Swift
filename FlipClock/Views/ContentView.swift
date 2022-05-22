import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            ClockView(config: FlipTextViewConfig(fontSize: 80.0))
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

