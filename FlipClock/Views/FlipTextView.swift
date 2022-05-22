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
                FlipTextViewHalf(text: viewModel.newValue ?? "", type: .top, config: config)
                FlipTextViewHalf(text: viewModel.oldValue ?? "", type: .top, config: config)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateTop ? -90 : .zero),
                                      axis: (1, 0, 0),
                                      anchor: .bottom,
                                      perspective: 0.5)
            }
            Color.black.frame(height: separatorHeight)
            ZStack {
                FlipTextViewHalf(text: viewModel.oldValue ?? "", type: .bottom, config: config)
                FlipTextViewHalf(text: viewModel.newValue ?? "", type: .bottom, config: config)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateBottom ? .zero : 90),
                                      axis: (1, 0, 0),
                                      anchor: .top,
                                      perspective: 0.5)
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
