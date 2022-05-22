import SwiftUI

struct FlipTextViewConfig {
    var backgroundColor = Color.black
    var textColor = Color.white
    var fontSize = 30.0
}

struct FlipTextView: View {
    @ObservedObject var viewModel: FlipViewModel

    var config = FlipTextViewConfig()
    var separatorHeight: Double {
        max(1.0, round(config.fontSize / 20.0))
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if let newVal = viewModel.newValue {
                    FlipTextViewHalf(text: newVal, type: .top, config: config)
                }
                if let oldVal = viewModel.oldValue {
                    FlipTextViewHalf(text: oldVal, type: .top, config: config)
                        .rotation3DEffect(.init(degrees: viewModel.animateTop ? -90 : 0),
                                          axis: (1, 0, 0),
                                          anchor: .bottom,
                                          perspective: 0.5)
                }
            }
            Color.black.frame(height: separatorHeight)
            ZStack {
                if let oldVal = viewModel.oldValue {
                    FlipTextViewHalf(text: oldVal, type: .bottom, config: config)
                }
                if let newVal = viewModel.newValue {
                    FlipTextViewHalf(text: newVal, type: .bottom, config: config)
                        .rotation3DEffect(.init(degrees: viewModel.animateBottom ? 0 : 90),
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
    static var previews: some View {
        Group {
            let m = FlipViewModel()
            let _ = m.updateTexts(old: "A", new: "B")
            FlipTextView(viewModel: m)
        }
    }
}
