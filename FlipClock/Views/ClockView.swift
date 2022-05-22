import SwiftUI

struct ClockView: View {
    let viewModel = ClockViewModel()
    var innerSpacing = 2.0
    var outerSpacing = 8.0
    var isTextBased = true
    var config = FlipTextViewConfig()

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
            FlipImageView(viewModel: viewModel)
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
