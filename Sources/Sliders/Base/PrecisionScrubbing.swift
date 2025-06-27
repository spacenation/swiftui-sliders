import SwiftUI

public struct PrecisionScrubbingConfig {
    let scrubValue: (Float) -> Float
    let onChange: ((Float?) -> Void)?
}

struct PrecisionScrubbingKey: EnvironmentKey {
    typealias Value = PrecisionScrubbingConfig

    static let defaultValue: PrecisionScrubbingConfig = PrecisionScrubbingConfig(
        scrubValue: { _ in 1 },
        onChange: nil
    )
}

extension EnvironmentValues {
    var precisionScrubbing: PrecisionScrubbingConfig {
        get { self[PrecisionScrubbingKey.self] }
        set { self[PrecisionScrubbingKey.self] = newValue }
    }
}

public extension View {
    func precisionScrubbing<ScrubValue: RawRepresentable<Float>>(
        _ scrubValue: @escaping (Float) -> ScrubValue,
        onChange: ((ScrubValue?) -> Void)? = nil
    ) -> some View  {
        self.environment(
            \.precisionScrubbing,
            PrecisionScrubbingConfig { offset in
                scrubValue(offset).rawValue
            } onChange: { value in
                guard let value else {
                    onChange?(nil)
                    return
                }

                if let value = ScrubValue(rawValue: value) {
                    onChange?(value)
                } else {
                    print("Invalid conversion")
                }
            }
        )
    }
}
