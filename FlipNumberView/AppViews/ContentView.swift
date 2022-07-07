import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 10.0) {
      Spacer()

      Text("Text based:")
      ClockView()
      Spacer().frame(height: 10.0)
      Text("Image based:")
      ClockView(isTextBased: false, imageScale: 0.6)

      Spacer()
    }
    #if os(macOS)
    .padding(100.0)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    #endif
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().preferredColorScheme(.light)
    ContentView().preferredColorScheme(.dark)
  }
}
