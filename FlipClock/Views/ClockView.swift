import SwiftUI

struct ClockView: View {
    let viewModel = ClockViewModel()
    var innerSpacing = 2.0
    var outerSpacing = 8.0
    var config = FlipViewConfig()

    var body: some View {
        HStack(spacing: outerSpacing) {
            HStack(spacing: innerSpacing) {
                FlipView(viewModel: viewModel.flipViewModels[0], config: config)
                FlipView(viewModel: viewModel.flipViewModels[1], config: config)
            }
            HStack(spacing: innerSpacing) {
                FlipView(viewModel: viewModel.flipViewModels[2], config: config)
                FlipView(viewModel: viewModel.flipViewModels[3], config: config)
            }
            HStack(spacing: innerSpacing) {
                FlipImageView(viewModel: viewModel.flipViewModels[4])
                FlipImageView(viewModel: viewModel.flipViewModels[5])
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
