//
//

import SwiftUI

struct FlipImageViewHalf: View {
  let value: Int
  let scale: Double
  let position: FlipImageViewPosition
  
  let bundle: Bundle
  let imageBundleName: String

  init(
    _ value: Int,
    scale: Double = 1.0,
    position: FlipImageViewPosition,
    bundle: Bundle = Bundle.main,
    imageBundleName: String = "JDFlipNumberView.bundle"
  ) {
    self.position = position
    self.value = value
    self.scale = scale
    self.bundle = bundle
    self.imageBundleName = imageBundleName
  }

  enum FlipImageViewPosition {
    case top
    case bottom
  }

  var paddingEdge: Edge.Set {
    switch position {
      case .top: return .bottom
      case .bottom: return .top
    }
  }

  var body: some View {
    if let imageBundle = bundle.path(forResource: imageBundleName, ofType: nil) {
      let imagePath = imageBundle.appending("/\(value).png")
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
      Text("[imageBundle n/a]")
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
        FlipImageViewHalf(0, scale: 0.33, position: .top)
        FlipImageViewHalf(0, scale: 0.33, position: .bottom)
      }
      VStack(spacing: 0.0) {
        FlipImageViewHalf(1, scale: 0.66, position: .top)
        FlipImageViewHalf(1, scale: 0.66, position: .bottom)
      }
      VStack(spacing: 0.0) {
        FlipImageViewHalf(2, position: .top)
        FlipImageViewHalf(2, position: .bottom)
      }
      VStack(spacing: 0.0) {
        FlipImageViewHalf(3, scale: 0.66, position: .top)
        FlipImageViewHalf(3, scale: 0.66, position: .bottom)
      }
      VStack(spacing: 0.0) {
        FlipImageViewHalf(4, scale: 0.33, position: .top)
        FlipImageViewHalf(4, scale: 0.33, position: .bottom)
      }
    }
    .macOnlyPadding(100.0)
  }
}
