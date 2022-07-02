import Combine
import SwiftUI

class FlipViewModel: ObservableObject, Identifiable {

    var duration: Double
    var text: String? {
        didSet { updateTexts(old: oldValue, new: text) }
    }

    init(duration: Double = 0.4, text: String? = "0") {
        self.duration = duration
        self.text = text
    }

    @Published var newValue: String? = "0"
    @Published var oldValue: String? = "0"

    @Published var animateTop: Bool = false
    @Published var animateBottom: Bool = false

    func updateTexts(old: String?, new: String?) {
        guard old != new else { return }
        oldValue = old
        animateTop = false
        animateBottom = false

        withAnimation(Animation.easeIn(duration: duration / 2.0)) { [weak self] in
            self?.newValue = new
            self?.animateTop = true
        }

        withAnimation(Animation.easeOut(duration: duration / 2.0).delay(duration / 2.0)) { [weak self] in
            self?.animateBottom = true
        }
    }

}
