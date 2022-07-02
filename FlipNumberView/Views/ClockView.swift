import SwiftUI

struct ClockView: View {
  var viewModel = ClockViewModel()
  var innerSpacing = 2.0
  var outerSpacing = 8.0
  var isTextBased = true
  var imageScale = 1.0
  var config = FlipTextViewConfig(fontSize: 50.0)

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
    let viewModel = viewModel.flipViewModels[idx]
    if isTextBased {
      FlipTextView(viewModel: viewModel, config: config)
    } else {
      FlipImageView(viewModel: viewModel, scale: imageScale)
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
