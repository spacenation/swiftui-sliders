import SwiftUI

struct PrecisionScrubbingKey: EnvironmentKey {
    static let defaultValue: (Float) -> Float = { _ in 1 }
}

extension EnvironmentValues {
    var precisionScrubbing: (Float) -> Float {
        get { self[PrecisionScrubbingKey.self] }
        set { self[PrecisionScrubbingKey.self] = newValue }
    }
}

public extension View {
    func precisionScrubbing<ScrubValue: RawRepresentable>(
        _ getScrubValue: @escaping (Float) -> ScrubValue
    ) -> some View
    where ScrubValue.RawValue == Float {
        self.environment(\.precisionScrubbing, { offset in
            getScrubValue(offset).rawValue
        })
    }
}
