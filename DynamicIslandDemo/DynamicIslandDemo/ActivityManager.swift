import ActivityKit
import Foundation

// Manager to control the Live Activity
class ActivityManager {
    static let shared = ActivityManager()
    
    @available(iOS 16.2, *)
    private var currentActivity: Activity<DemoActivityAttributes>?
    
    private init() {}
    
    @available(iOS 16.2, *)
    func startActivity() {
        // Create the attributes (never changes)
        let attributes = DemoActivityAttributes(title: "Dynamic Island Demo")
        
        // Create initial state (can be updated)
        let initialState = DemoActivityAttributes.ContentState(
            score: 0,
            emoji: "⭐️"
        )
        
        do {
            // Start the Live Activity
            currentActivity = try Activity.request(
                attributes: attributes,
                content: .init(state: initialState, staleDate: nil),
                pushType: nil
            )
            print("✅ Live Activity started!")
        } catch {
            print("❌ Error starting Live Activity: \(error)")
        }
    }
    
    @available(iOS 16.2, *)
    func updateActivity(score: Int) {
        guard let activity = currentActivity else {
            print("⚠️ No active Live Activity")
            return
        }
        
        // Create new state
        let newState = DemoActivityAttributes.ContentState(
            score: score,
            emoji: score >= 80 ? "🎉" : score >= 50 ? "⭐️" : "💫"
        )
        
        Task {
            await activity.update(.init(state: newState, staleDate: nil))
            print("✅ Updated to score: \(score)")
        }
    }
    
    @available(iOS 16.2, *)
    func endActivity() {
        guard let activity = currentActivity else {
            print("⚠️ No active Live Activity")
            return
        }
        
        Task {
            await activity.end(nil, dismissalPolicy: .immediate)
            currentActivity = nil
            print("✅ Live Activity ended")
        }
    }
}
