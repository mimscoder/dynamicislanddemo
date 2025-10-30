import ActivityKit
import Foundation

// Define what data the Live Activity will display
struct DemoActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // This data can be updated
        var score: Int
        var emoji: String
    }
    
    // This data is set once and never changes
    var title: String
}
