import SwiftUI

struct FlipTextViewHalf: View {
  // content
  let text: Character

  // config
  let type: FlipType
  var config: FlipTextViewConfig = .init()

  // derived
  var cornerRadius: Double {
    max(4.0, round(config.fontSize / 16.0))
  }

  var body: some View {
    let font = Font.system(size: config.fontSize).weight(.heavy).monospaced()
    let clippingPadding = round(config.fontSize / -1.95)
    let outerPadding = max(self.minVerticalClipping, (80 - config.fontSize) / 5.0)
    let horizontalPadding = 10.0
    let backgroundPadding = round(config.fontSize / -12.0)
    let backgroundShape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

    Group {
      switch type {
      case .top:
        Text(String(text))
          .padding(.bottom, clippingPadding)
          .padding(.top, outerPadding)
          .padding([.leading, .trailing], horizontalPadding)
          .background(config.backgroundColor, in: backgroundShape)
          .padding(.bottom, backgroundPadding)
      case .bottom:
        Text(String(text))
          .padding(.top, clippingPadding)
          .padding(.bottom, outerPadding)
          .padding([.leading, .trailing], horizontalPadding)
          .background(config.backgroundColor, in: backgroundShape)
          .padding(.top, backgroundPadding)
      }
    }
    .font(font)
    .foregroundColor(config.textColor)
    .clipped()
  }

  var minVerticalClipping: Double {
    #if os(macOS)
    return 10.0
    #else
    return -6.0
    #endif
  }

  enum FlipType {
    case top
    case bottom
  }
}

struct FlipTextViewHalf_Previews: PreviewProvider {
  static let config1 = FlipTextViewConfig(backgroundColor: .black,
                                          textColor: .white,
                                          fontSize: 80.0)
  static let config2 = FlipTextViewConfig(textColor: .teal,
                                          fontSize: 120.0)
  static let config3 = FlipTextViewConfig(backgroundColor: .indigo,
                                          textColor: .white,
                                          fontSize: 80.0)
  static let config4 = FlipTextViewConfig(backgroundColor: .teal,
                                          textColor: .black,
                                          fontSize: 45.0)

  static var previews: some View {
    HStack {
      VStack(spacing: 0.0) {
        FlipTextViewHalf(text: "0", type: .top, config: config1)
        Spacer().frame(height: 1.0)
        FlipTextViewHalf(text: "0", type: .bottom, config: config1)
      }.fixedSize()
      VStack(spacing: 0.0) {
        FlipTextViewHalf(text: "3", type: .top, config: config2)
        Spacer().frame(height: 1.0)
        FlipTextViewHalf(text: "3", type: .bottom, config: config2)
      }.fixedSize()
      VStack(spacing: 0.0) {
        FlipTextViewHalf(text: "2", type: .top, config: config3)
        Spacer().frame(height: 1.0)
        FlipTextViewHalf(text: "2", type: .bottom, config: config3)
      }.fixedSize()
      VStack(spacing: 0.0) {
        FlipTextViewHalf(text: "1", type: .top, config: config4)
        Spacer().frame(height: 1.0)
        FlipTextViewHalf(text: "1", type: .bottom, config: config4)
      }.fixedSize()
    }
    .macOnlyPadding(50.0)
  }
}
