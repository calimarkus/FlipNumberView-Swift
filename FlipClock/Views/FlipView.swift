import SwiftUI

struct FlipView: View {

    @ObservedObject var viewModel: FlipViewModel
    var fontSize: Double = 40.0
    var separatorHeight: Double {
        max(1.0, round(fontSize / 20.0))
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                SingleFlipView(text: viewModel.newValue ?? "", type: .top, fontSize: fontSize)
                SingleFlipView(text: viewModel.oldValue ?? "", type: .top, fontSize: fontSize)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateTop ? -90 : .zero),
                                      axis: (1, 0, 0),
                                      anchor: .bottom,
                                      perspective: 0.5)
            }
            Color.separator.frame(height: separatorHeight)
            ZStack {
                SingleFlipView(text: viewModel.oldValue ?? "", type: .bottom, fontSize: fontSize)
                SingleFlipView(text: viewModel.newValue ?? "", type: .bottom, fontSize: fontSize)
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
