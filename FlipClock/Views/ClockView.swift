import SwiftUI

struct ClockView: View {

    let viewModel = ClockViewModel()
    var innerSpacing = 2.0
    var outerSpacing = 8.0
    var fontSize = 65.0

    var body: some View {
        HStack(spacing: outerSpacing) {
            HStack(spacing: innerSpacing) {
                FlipView(viewModel: viewModel.flipViewModels[0], fontSize: fontSize)
                FlipView(viewModel: viewModel.flipViewModels[1], fontSize: fontSize)
            }
            HStack(spacing: innerSpacing) {
                FlipView(viewModel: viewModel.flipViewModels[2], fontSize: fontSize)
                FlipView(viewModel: viewModel.flipViewModels[3], fontSize: fontSize)
            }
            HStack(spacing: innerSpacing) {
                FlipView(viewModel: viewModel.flipViewModels[4], fontSize: fontSize)
                FlipView(viewModel: viewModel.flipViewModels[5], fontSize: fontSize)
            }
        }
    }

}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}

