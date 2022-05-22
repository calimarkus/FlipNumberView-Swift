import SwiftUI

struct FlipImageView: View {
    @ObservedObject var viewModel: FlipViewModel

    var scale: Double = 1.0

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if let newVal = viewModel.newValue {
                    FlipImageViewHalf(.top, value: Int(newVal) ?? 0, scale: scale)
                }
                if let oldVal = viewModel.oldValue {
                    FlipImageViewHalf(.top, value: Int(oldVal) ?? 0, scale: scale)
                        .rotation3DEffect(
                            .init(degrees: self.viewModel.animateTop ? -90 : .zero),
                            axis: (1, 0, 0),
                            anchor: .bottom,
                            perspective: 0.5)
                }
            }
            ZStack {
                if let oldVal = viewModel.oldValue {
                    FlipImageViewHalf(.bottom, value: Int(oldVal) ?? 0, scale: scale)
                }
                if let newVal = viewModel.newValue {
                    FlipImageViewHalf(.bottom, value: Int(newVal) ?? 0, scale: scale)
                        .rotation3DEffect(
                            .init(degrees: self.viewModel.animateBottom ? .zero : 90),
                            axis: (1, 0, 0),
                            anchor: .top,
                            perspective: 0.5)
                }
            }
        }
    }
}

struct FlipImageView_Previews: PreviewProvider {
    static var previews: some View {
        let m = FlipViewModel()
        let _ = m.updateTexts(old: "A", new: "B")
        FlipImageView(viewModel: m, scale: 0.75)
    }
}
