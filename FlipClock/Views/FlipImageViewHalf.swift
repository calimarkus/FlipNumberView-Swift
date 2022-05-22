//
//

import SwiftUI

enum FlipImageViewPosition {
    case top
    case bottom
}

struct FlipImageViewHalf: View {
    let position: FlipImageViewPosition
    let value: Int

    init(_ position: FlipImageViewPosition, value: Int) {
        self.position = position
        self.value = value
    }

    var body: some View {
        if let bundle = Bundle.main.path(forResource: "JDFlipNumberView.bundle", ofType: nil),
           let img = UIImage(contentsOfFile: bundle.appending("/\(value).png"))
        {
            switch position {
            case .top:
                Image(uiImage: img)
                    .padding(padding, -img.size.height / 2.0)
                    .clipped()
            case .bottom:
                Image(uiImage: img)
                    .padding(padding, -img.size.height / 2.0)
                    .clipped()
            }

        } else {
            Text("[img n/a]")
        }
    }

    var padding: Edge.Set {
        switch position {
        case .top:
            return .bottom
        case .bottom:
            return .top
        }
    }

    var paddingEdges: Edge.Set {
        switch position {
        case .top:
            return [.top, .leading, .trailing]
        case .bottom:
            return [.bottom, .leading, .trailing]
        }
    }
}

struct FlipImageViewHalf_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack(spacing: 0.0) {
                FlipImageViewHalf(.top, value: 0)
                FlipImageViewHalf(.bottom, value: 0)
            }
            VStack(spacing: 0.0) {
                FlipImageViewHalf(.top, value: 1)
                FlipImageViewHalf(.bottom, value: 1)
            }
            VStack(spacing: 0.0) {
                FlipImageViewHalf(.top, value: 2)
                FlipImageViewHalf(.bottom, value: 2)
            }
            VStack(spacing: 0.0) {
                FlipImageViewHalf(.top, value: 3)
                FlipImageViewHalf(.bottom, value: 3)
            }
        }
    }
}
