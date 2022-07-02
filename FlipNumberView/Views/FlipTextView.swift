import SwiftUI

struct FlipTextViewConfig {
  var backgroundColor = Color.clockBackgroundColor
  var textColor = Color.clockTextColor
  var fontSize = 80.0
}

struct FlipTextView: View {
  @ObservedObject var viewModel: FlipViewModel

  var config = FlipTextViewConfig()
  var separatorHeight: Double {
    max(1.0, round(config.fontSize / 40.0))
  }

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        if let newVal = viewModel.newValue {
          FlipTextViewHalf(text: newVal, type: .top, config: config)
        }
        if let oldVal = viewModel.oldValue {
          FlipTextViewHalf(text: oldVal, type: .top, config: config)
            .rotation3DEffect(.init(degrees: viewModel.animateTop ? -89.999 : 0),
                              axis: (1, 0, 0),
                              anchor: .bottom,
                              perspective: 0.5)
        }
      }
      Color.clockTextColor.frame(height: separatorHeight)
      ZStack {
        if let oldVal = viewModel.oldValue {
          FlipTextViewHalf(text: oldVal, type: .bottom, config: config)
        }
        if let newVal = viewModel.newValue {
          FlipTextViewHalf(text: newVal, type: .bottom, config: config)
            .rotation3DEffect(.init(degrees: viewModel.animateBottom ? 0 : 89.999),
                              axis: (1, 0, 0),
                              anchor: .top,
                              perspective: 0.5)
        }
      }
    }
    .fixedSize()
  }
}

struct FlipTextView_Previews: PreviewProvider {
  @State static var viewModel = ClockViewModel(animationDuration: 0.9)

  static var previews: some View {
    Group {
      let m = viewModel.flipViewModels[5]
      FlipTextView(viewModel: m).preferredColorScheme(.light)
      FlipTextView(viewModel: m).preferredColorScheme(.dark)
    }
    .macOnlyPadding(40.0)
  }
}
