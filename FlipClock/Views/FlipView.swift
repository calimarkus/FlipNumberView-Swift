import SwiftUI

struct FlipViewConfig {
    var backgroundColor = Color.black
    var textColor = Color.white
    var fontSize = 30.0
}

struct FlipView: View {

    @ObservedObject var viewModel: FlipViewModel

    var config = FlipViewConfig()
    var separatorHeight: Double {
        max(1.0, round(config.fontSize / 20.0))
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SingleFlipView(text: viewModel.newValue ?? "", type: .top, config: config)
                SingleFlipView(text: viewModel.oldValue ?? "", type: .top, config: config)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateTop ? -90 : .zero),
                                      axis: (1, 0, 0),
                                      anchor: .bottom,
                                      perspective: 0.5)
            }
            Color.black.frame(height: separatorHeight)
            ZStack {
                SingleFlipView(text: viewModel.oldValue ?? "", type: .bottom, config: config)
                SingleFlipView(text: viewModel.newValue ?? "", type: .bottom, config: config)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateBottom ? .zero : 90),
                                      axis: (1, 0, 0),
                                      anchor: .top,
                                      perspective: 0.5)
            }
        }
        .fixedSize()
    }
}

struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let m = FlipViewModel()
            let _ = m.updateTexts(old: "A", new: "B")
            FlipView(viewModel: m)
        }
    }
}
