//
//

import SwiftUI

extension View {
  func macOnlyPadding(_ padding: Double) -> some View {
    modifier(MacOnlyPadding(padding: padding))
  }
}

struct MacOnlyPadding: ViewModifier {
  let padding: Double

  func body(content: Content) -> some View {
    content
    #if os(macOS)
    .padding(padding)
    #endif
  }
}
