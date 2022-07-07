import SwiftUI

struct FlipTextViewConfig {
  var backgroundColor = Color.black
  var textColor = Color.white
  var fontSize = 80.0
  var animationDuration: Double = 0.4

  var separatorHeight: Double {
    max(1.0, round(fontSize / 40.0))
  }
}

struct FlipTextView: View {
  @Binding var value: Character
  var config = FlipTextViewConfig()

  // Internal State
  @State private var currentValue: Character
  @State private var previousValue: Character
  @State private var animateTop: Bool = false
  @State private var animateBottom: Bool = false

  init(_ value: Binding<Character>,
       config: FlipTextViewConfig = FlipTextViewConfig())
  {
    self._value = value
    self.config = config

    self.currentValue = value.wrappedValue
    self.previousValue = value.wrappedValue
  }

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        FlipTextViewHalf(text: currentValue, type: .top, config: config)
        FlipTextViewHalf(text: previousValue, type: .top, config: config)
          .rotation3DEffect(.init(degrees: animateTop ? -89.999 : 0),
                            axis: (1, 0, 0),
                            anchor: .bottom,
                            perspective: 0.5)
      }
      config.textColor.frame(height: config.separatorHeight)
      ZStack {
        FlipTextViewHalf(text: previousValue, type: .bottom, config: config)
        FlipTextViewHalf(text: currentValue, type: .bottom, config: config)
          .rotation3DEffect(.init(degrees: animateBottom ? 0 : 89.999),
                            axis: (1, 0, 0),
                            anchor: .top,
                            perspective: 0.5)
      }
    }
    .fixedSize()
    .onChange(of: value) { newValue in
      guard currentValue != newValue else { return }
      previousValue = currentValue
      animateTop = false
      animateBottom = false

      withAnimation(Animation.easeIn(duration: config.animationDuration / 2.0)) {
        currentValue = newValue
        animateTop = true
      }
      withAnimation(Animation.easeOut(duration: config.animationDuration / 2.0).delay(config.animationDuration / 2.0)) {
        animateBottom = true
      }
    }
  }
}

struct FlipTextView_Previews: PreviewProvider {
  static var previews: some View {
    FlipTextView(.constant("0")).preferredColorScheme(.light)
      .macOnlyPadding(40.0)
  }
}
