import Combine
import Foundation
import SwiftUI

class ClockModel: ObservableObject {
  @Published var values: [Int] = []
  private var cancellables = Set<AnyCancellable>()
  private let timeFormatter = DateFormatter.timeFormatter

  init() {
    setupTimer()
    updateCharacterMap(timeFormatter.string(from: Date()))
  }

  private func setupTimer() {
    Timer.publish(every: 1, on: .main, in: .default)
      .autoconnect()
      .map { [timeFormatter] in timeFormatter.string(from: $0) }
      .removeDuplicates()
      .sink(receiveValue: { [weak self] in self?.updateCharacterMap($0) })
      .store(in: &cancellables)
  }

  private func updateCharacterMap(_ time: String) {
    values = Array(time).map { Int(String($0)) ?? 0 }
  }
}
