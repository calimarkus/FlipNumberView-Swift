import SwiftUI

struct SingleFlipView: View {
    let text: String
    let type: FlipType
    var fontSize = 40.0
    var cornerRadius: Double {
        max(4.0, round(fontSize / 16.0))
    }

    var body: some View {
        Text(text)
            .font(.custom("Helvetica", size: fontSize)
                .weight(.heavy))
            .foregroundColor(.textColor)
            .padding(type.padding, round(fontSize / -2.0))
            .padding(type.paddingEdges, 10.0)
            .clipped()
            .background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .padding(type.padding, round(fontSize / -12.0))
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
                SingleFlipView(text: "0", type: .top, fontSize: 15.0)
                Spacer().frame(height: 1.0)
                SingleFlipView(text: "0", type: .bottom, fontSize: 15.0)
            }.fixedSize()
            VStack(spacing: 0.0) {
                SingleFlipView(text: "1", type: .top)
                Spacer().frame(height: 1.0)
                SingleFlipView(text: "1", type: .bottom)
            }.fixedSize()
            VStack(spacing: 0.0) {
                SingleFlipView(text: "2", type: .top, fontSize: 80.0)
                Spacer().frame(height: 1.0)
                SingleFlipView(text: "2", type: .bottom, fontSize: 80.0)
            }.fixedSize()
            VStack(spacing: 0.0) {
                SingleFlipView(text: "3", type: .top, fontSize: 120.0)
                Spacer().frame(height: 1.0)
                SingleFlipView(text: "3", type: .bottom, fontSize: 120)
            }.fixedSize()
        }
    }
}
