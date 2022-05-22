import SwiftUI

struct SingleFlipView: View {
    // content
    let text: String

    // config
    let type: FlipType
    var config: FlipViewConfig = FlipViewConfig()

    // derived
    var cornerRadius: Double {
        max(4.0, round(config.fontSize / 16.0))
    }

    var body: some View {
        Text(text)
            .font(.custom("Helvetica", size: config.fontSize)
                .weight(.heavy))
            .foregroundColor(config.textColor)
            .padding(type.padding, round(config.fontSize / -2.0))
            .padding(type.paddingEdges, 10.0)
            .clipped()
            .background(config.backgroundColor, in:RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .padding(type.padding, round(config.fontSize / -12.0))
            .clipped()
    }

    enum FlipType {
        case top
        case bottom

        var padding: Edge.Set {
            switch self {
            case .top:
                return .bottom
            case .bottom:
                return .top
            }
        }

        var paddingEdges: Edge.Set {
            switch self {
            case .top:
                return [.top, .leading, .trailing]
            case .bottom:
                return [.bottom, .leading, .trailing]
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

struct SingleFlipView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack(spacing: 0.0) {
                SingleFlipView(text: "0", type: .top, config: FlipViewConfig(fontSize: 15.0))
                Spacer().frame(height: 1.0)
                SingleFlipView(text: "0", type: .bottom, config: FlipViewConfig(fontSize: 15.0))
            }.fixedSize()
            VStack(spacing: 0.0) {
                SingleFlipView(text: "1", type: .top)
                Spacer().frame(height: 1.0)
                SingleFlipView(text: "1", type: .bottom)
            }.fixedSize()
            VStack(spacing: 0.0) {
                SingleFlipView(text: "2", type: .top, config: FlipViewConfig(fontSize: 80.0))
                Spacer().frame(height: 1.0)
                SingleFlipView(text: "2", type: .bottom, config: FlipViewConfig(fontSize: 80.0))
            }.fixedSize()
            VStack(spacing: 0.0) {
                SingleFlipView(text: "3", type: .top, config: FlipViewConfig(fontSize: 120.0))
                Spacer().frame(height: 1.0)
                SingleFlipView(text: "3", type: .bottom, config: FlipViewConfig(fontSize: 120.0))
            }.fixedSize()
        }
    }
}
