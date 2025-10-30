import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var activity: Activity<DemoActivityAttributes>?
    @State private var currentScore: Int = 0
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Header
                VStack(spacing: 8) {
                    Text("Dynamic Island Demo")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("Test Live Activities")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 60)
                
                Spacer()
                
                // Score Display
                VStack(spacing: 16) {
                    // Large emoji
                    Text("⭐️")
                        .font(.system(size: 80))
                    
                    // Score
                    VStack(spacing: 4) {
                        Text("\(currentScore)")
                            .font(.system(size: 72, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Text("POINTS")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .tracking(2)
                    }
                    
                    // Progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(.tertiary)
                                .frame(height: 8)
                            
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [.purple, .blue, .cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(
                                    width: max(geometry.size.width * CGFloat(currentScore) / 100, 10),
                                    height: 8
                                )
                        }
                    }
                    .frame(height: 8)
                    .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Buttons
                VStack(spacing: 16) {
                    // Start Button
                    Button(action: startActivity) {
                        HStack {
                            Image(systemName: "play.fill")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Start Live Activity")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    }
                    .disabled(activity != nil)
                    .opacity(activity != nil ? 0.5 : 1.0)
                    
                    // Update Button
                    Button(action: updateScore) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Update Score")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    }
                    .disabled(activity == nil)
                    .opacity(activity == nil ? 0.5 : 1.0)
                    
                    // End Button
                    Button(action: endActivity) {
                        HStack {
                            Image(systemName: "stop.fill")
                                .font(.system(size: 18, weight: .semibold))
                            Text("End Live Activity")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    }
                    .disabled(activity == nil)
                    .opacity(activity == nil ? 0.5 : 1.0)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
    
    func startActivity() {
        currentScore = 0
        
        let attributes = DemoActivityAttributes(title: "Dynamic Island Demo")
        let contentState = DemoActivityAttributes.ContentState(score: currentScore, emoji: "⭐️")
        
        do {
            activity = try Activity.request(
                attributes: attributes,
                content: .init(state: contentState, staleDate: nil)
            )
            print("✅ Live Activity started!")
        } catch {
            print("❌ Error starting Live Activity: \(error)")
        }
    }
    
    func updateScore() {
        guard let activity = activity else { return }
        
        // Random score between 1 and 100
        currentScore = Int.random(in: 1...100)
        
        Task {
            let updatedState = DemoActivityAttributes.ContentState(score: currentScore, emoji: "⭐️")
            let content = ActivityContent(state: updatedState, staleDate: nil)
            await activity.update(content)
            print("✅ Updated to score: \(currentScore)")
        }
    }
    
    func endActivity() {
        guard let activity = activity else { return }
        
        Task {
            let finalState = DemoActivityAttributes.ContentState(score: currentScore, emoji: "⭐️")
            let finalContent = ActivityContent(state: finalState, staleDate: nil)
            await activity.end(finalContent, dismissalPolicy: .immediate)
            self.activity = nil
            self.currentScore = 0
            print("✅ Live Activity ended")
        }
    }
}

#Preview {
    ContentView()
}
