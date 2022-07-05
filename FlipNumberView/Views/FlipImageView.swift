import SwiftUI

struct FlipImageView: View {
  @ObservedObject var viewModel: FlipViewModel

  var scale: Double = 1.0

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        if let newVal = viewModel.newValue {
          FlipImageViewHalf(Int(newVal) ?? 0, scale: scale, position: .top)
        }
        if let oldVal = viewModel.oldValue {
          FlipImageViewHalf(Int(oldVal) ?? 0, scale: scale, position: .top)
            .rotation3DEffect(
              .init(degrees: self.viewModel.animateTop ? -89.999 : .zero),
              axis: (1, 0, 0),
              anchor: .bottom,
              perspective: 0.5)
        }
      }
      ZStack {
        if let oldVal = viewModel.oldValue {
          FlipImageViewHalf(Int(oldVal) ?? 0, scale: scale, position: .bottom)
        }
        if let newVal = viewModel.newValue {
          FlipImageViewHalf(Int(newVal) ?? 0, scale: scale, position: .bottom)
            .rotation3DEffect(
              .init(degrees: self.viewModel.animateBottom ? .zero : 89.999),
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
    let _ = m.updateTexts(old: "0", new: "1")
    HStack {
      FlipImageView(viewModel: m, scale: 0.33)
      FlipImageView(viewModel: m, scale: 0.66)
      FlipImageView(viewModel: m)
      FlipImageView(viewModel: m, scale: 0.66)
      FlipImageView(viewModel: m, scale: 0.33)
    }.macOnlyPadding(100.0)
  }
}
