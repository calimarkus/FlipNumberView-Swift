import Combine
import Foundation
import SwiftUI

class ClockModel<T>: ObservableObject {
  @Published var values: [T] = []
  var valueMapper: (Character) -> T

  private var cancellables = Set<AnyCancellable>()
  private let timeFormatter: DateFormatter

  init(valueMapper: @escaping (Character) -> T) {
    self.valueMapper = valueMapper
    self.timeFormatter = DateFormatter()
    self.timeFormatter.dateFormat = "HHmmss"

    setupTimer()
    mapValues(Date())
  }

  private func setupTimer() {
    Timer.publish(every: 1, on: .main, in: .default)
      .autoconnect()
      .sink(receiveValue: { [weak self] in self?.mapValues($0) })
      .store(in: &cancellables)
  }

  private func mapValues(_ date: Date) {
    let dateString = timeFormatter.string(from: date)
    values = Array(dateString).map(valueMapper)
  }
}
