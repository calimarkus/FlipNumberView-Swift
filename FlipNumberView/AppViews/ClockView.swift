import SwiftUI

struct ClockView: View {
  var isTextBased = true
  var innerSpacing = 2.0
  var outerSpacing = 8.0

  @ObservedObject var textBasedModel = ClockModel { $0 }
  @ObservedObject var imageBasedModel = ClockModel { Int(String($0)) ?? 0 }
  var imageScale = 1.0

  var body: some View {
    HStack(spacing: outerSpacing) {
      HStack(spacing: innerSpacing) {
        flipViewAtIndex(0)
        flipViewAtIndex(1)
      }
      HStack(spacing: innerSpacing) {
        flipViewAtIndex(2)
        flipViewAtIndex(3)
      }
      HStack(spacing: innerSpacing) {
        flipViewAtIndex(4)
        flipViewAtIndex(5)
      }
    }
  }

  @ViewBuilder
  func flipViewAtIndex(_ idx: Int) -> some View {
    if isTextBased {
      let config = FlipTextViewConfig(backgroundColor: Color.clockBackgroundColor,
                                      textColor: Color.clockTextColor,
                                      fontSize: 50.0,
                                      animationDuration: 0.4)
      FlipTextView($textBasedModel.values[idx], config: config)
    } else {
      FlipImageView($imageBasedModel.values[idx],
                    scale: imageScale,
                    animationDuration: 0.66)
    }
  }
}

struct ClockView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 50.0) {
      ClockView()
      ClockView(isTextBased: false, imageScale: 0.6)
    }
    .macOnlyPadding(100.0)
  }
}
