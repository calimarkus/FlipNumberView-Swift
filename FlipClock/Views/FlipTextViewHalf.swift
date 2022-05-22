import SwiftUI

struct FlipTextViewHalf: View {
    // content
    let text: String

    // config
    let type: FlipType
    var config: FlipTextViewConfig = FlipTextViewConfig()

    // derived
    var cornerRadius: Double {
        max(4.0, round(config.fontSize / 16.0))
    }

    var body: some View {
        Text(text)
            .font(.custom("Helvetica", size: config.fontSize)
                .weight(.heavy))
            .foregroundColor(config.textColor)
            .padding(type.clippingEdge, round(config.fontSize / -2.0))
            .padding(type.verticalPaddingEdge, max(-6.0, (80 - config.fontSize) / 5.0))
            .padding([.leading, .trailing], 10.0)
            .clipped()
            .background(config.backgroundColor, in:RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .padding(type.clippingEdge, round(config.fontSize / -12.0))
            .clipped()
    }

    enum FlipType {
        case top
        case bottom

        var clippingEdge: Edge.Set {
            switch self {
            case .top:
                return .bottom
            case .bottom:
                return .top
            }
        }

        var verticalPaddingEdge: Edge.Set {
            switch self {
            case .top:
                return [.top]
            case .bottom:
                return [.bottom]
            }
        }

        var alignment: Alignment {
            switch self {
            case .top:
                return .bottom
            case .bottom:
                return .top
            }
        }
    }
}

struct FlipTextViewHalf_Previews: PreviewProvider {
    static let config1 = FlipTextViewConfig(backgroundColor: .black,
                                        textColor: .white,
                                        fontSize: 15.0)
    static let config2 = FlipTextViewConfig(backgroundColor: .teal,
                                        textColor: .black,
                                        fontSize: 45.0)
    static let config3 = FlipTextViewConfig(backgroundColor: .indigo,
                                        textColor: .white,
                                        fontSize: 80.0)
    static let config4 = FlipTextViewConfig(backgroundColor: .black.opacity(0.15),
                                        textColor: .teal,
                                        fontSize: 120.0)

    static var previews: some View {
        HStack {
            VStack(spacing: 0.0) {
                FlipTextViewHalf(text: "0", type: .top, config: config1)
                Spacer().frame(height: 1.0)
                FlipTextViewHalf(text: "0", type: .bottom, config: config1)
            }.fixedSize()
            VStack(spacing: 0.0) {
                FlipTextViewHalf(text: "1", type: .top, config: config2)
                Spacer().frame(height: 1.0)
                FlipTextViewHalf(text: "1", type: .bottom, config: config2)
            }.fixedSize()
            VStack(spacing: 0.0) {
                FlipTextViewHalf(text: "2", type: .top, config: config3)
                Spacer().frame(height: 1.0)
                FlipTextViewHalf(text: "2", type: .bottom, config: config3)
            }.fixedSize()
            VStack(spacing: 0.0) {
                FlipTextViewHalf(text: "3", type: .top, config: config4)
                Spacer().frame(height: 1.0)
                FlipTextViewHalf(text: "3", type: .bottom, config: config4)
            }.fixedSize()
        }
    }
}
