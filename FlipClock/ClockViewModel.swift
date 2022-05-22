import Foundation
import Combine

class ClockViewModel {

    init() {
        setupTimer()
        setTimeInViewModels(time: timeFormatter.string(from: Date()))
    }

    private(set) var flipViewModels = (0...5).map { _ in FlipViewModel() }

    private func setupTimer() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { [timeFormatter] in timeFormatter.string(from: $0) }
            .removeDuplicates()
            .sink(receiveValue: { [weak self] in self?.setTimeInViewModels(time: $0) })
            .store(in: &cancellables)
    }

    private func setTimeInViewModels(time: String) {
        zip(time, flipViewModels).forEach { number, viewModel in
            viewModel.text = "\(number)"
        }
    }

    private var cancellables = Set<AnyCancellable>()
    private let timeFormatter = DateFormatter.timeFormatter

}
