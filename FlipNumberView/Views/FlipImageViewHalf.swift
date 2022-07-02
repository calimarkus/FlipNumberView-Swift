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
  let scale: Double

  var paddingEdge: Edge.Set {
    switch position {
      case .top: return .bottom
      case .bottom: return .top
    }
  }

  init(_ position: FlipImageViewPosition, value: Int, scale: Double = 1.0) {
    self.position = position
    self.value = value
    self.scale = scale
  }

  var body: some View {
    if let bundle = Bundle.main.path(forResource: "JDFlipNumberView.bundle", ofType: nil) {
      let imagePath = bundle.appending("/\(value).png")
      if let (image, width, height) = platformImage(imagePath: imagePath) {
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: width * scale, height: height * scale)
          .padding(paddingEdge, -height / 2.0 * scale)
          .clipped()
      } else {
        Text("[image n/a]")
      }
    } else {
      Text("[bundle n/a]")
    }
  }

  func platformImage(imagePath: String) -> (Image, Double, Double)? {
    #if os(iOS)
    if let img = UIImage(contentsOfFile: imagePath) {
      return (Image(uiImage: img), Double(img.size.width), Double(img.size.height))
    }
    #elseif os(macOS)
    if let img = NSImage(contentsOfFile: imagePath) {
      return (Image(nsImage: img), Double(img.size.width), Double(img.size.height))
    }
    #endif
    return nil
  }
}

struct FlipImageViewHalf_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      VStack(spacing: 0.0) {
        FlipImageViewHalf(.top, value: 0, scale: 0.33)
        FlipImageViewHalf(.bottom, value: 0, scale: 0.33)
      }
      VStack(spacing: 0.0) {
        FlipImageViewHalf(.top, value: 1, scale: 0.66)
        FlipImageViewHalf(.bottom, value: 1, scale: 0.66)
      }
      VStack(spacing: 0.0) {
        FlipImageViewHalf(.top, value: 2)
        FlipImageViewHalf(.bottom, value: 2)
      }
      VStack(spacing: 0.0) {
        FlipImageViewHalf(.top, value: 3, scale: 0.66)
        FlipImageViewHalf(.bottom, value: 3, scale: 0.66)
      }
      VStack(spacing: 0.0) {
        FlipImageViewHalf(.top, value: 4, scale: 0.33)
        FlipImageViewHalf(.bottom, value: 4, scale: 0.33)
      }
    }
    .macOnlyPadding(100.0)
  }
}
