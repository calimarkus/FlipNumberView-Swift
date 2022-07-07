import SwiftUI

struct FlipImageView: View {
  @Binding var value: Int
  var scale: Double
  var animationDuration: Double

  // Internal State
  @State private var currentValue: Int
  @State private var previousValue: Int
  @State private var animateTop: Bool = false
  @State private var animateBottom: Bool = false

  init(_ value: Binding<Int>, scale: Double = 1.0, animationDuration: Double = 0.4) {
    self._value = value
    self.scale = scale
    self.animationDuration = animationDuration

    self.currentValue = value.wrappedValue
    self.previousValue = value.wrappedValue
  }

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        FlipImageViewHalf(currentValue, scale: scale, position: .top)
        FlipImageViewHalf(previousValue, scale: scale, position: .top)
          .rotation3DEffect(
            .init(degrees: animateTop ? -89.999 : .zero),
            axis: (1, 0, 0),
            anchor: .bottom,
            perspective: 0.5)
      }
      ZStack {
        FlipImageViewHalf(previousValue, scale: scale, position: .bottom)
        FlipImageViewHalf(currentValue, scale: scale, position: .bottom)
          .rotation3DEffect(
            .init(degrees: animateBottom ? .zero : 89.999),
            axis: (1, 0, 0),
            anchor: .top,
            perspective: 0.5)
      }
    }.onChange(of: value) { newValue in
      guard currentValue != newValue else { return }
      previousValue = currentValue
      animateTop = false
      animateBottom = false

      withAnimation(Animation.easeIn(duration: animationDuration / 2.0)) {
        currentValue = newValue
        animateTop = true
      }
      withAnimation(Animation.easeOut(duration: animationDuration / 2.0).delay(animationDuration / 2.0)) {
        animateBottom = true
      }
    }
  }
}

struct FlipImageView_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      FlipImageView(.constant(0), scale: 0.33)
      FlipImageView(.constant(1), scale: 0.66)
      FlipImageView(.constant(2))
      FlipImageView(.constant(3), scale: 0.66)
      FlipImageView(.constant(4), scale: 0.33)
    }.macOnlyPadding(100.0)
  }
}
