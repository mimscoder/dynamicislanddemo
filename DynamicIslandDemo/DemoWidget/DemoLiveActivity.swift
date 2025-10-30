import ActivityKit
import WidgetKit
import SwiftUI

struct DemoLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DemoActivityAttributes.self) { context in
            // Lock Screen UI - Beautiful card design
            HStack(spacing: 16) {
                // Animated emoji with glow
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.purple.opacity(0.3), .blue.opacity(0.2), .clear],
                                center: .center,
                                startRadius: 10,
                                endRadius: 40
                            )
                        )
                        .frame(width: 80, height: 80)
                    
                    Text(context.state.emoji)
                        .font(.system(size: 45))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(context.attributes.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    HStack(spacing: 4) {
                        Text("\(context.state.score)")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Text("pts")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .offset(y: 8)
                    }
                    
                    // Animated progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(.tertiary)
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [.purple, .blue, .cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(
                                    width: max(geometry.size.width * CGFloat(context.state.score) / 100, 10),
                                    height: 6
                                )
                        }
                    }
                    .frame(height: 6)
                }
                
                Spacer()
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
            )
            
        } dynamicIsland: { context in
            DynamicIsland {
                // EXPANDED VIEW - Premium design
                DynamicIslandExpandedRegion(.leading) {
                    HStack(spacing: 12) {
                        // Glowing emoji
                        ZStack {
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            .yellow.opacity(0.4),
                                            .orange.opacity(0.2),
                                            .clear
                                        ],
                                        center: .center,
                                        startRadius: 5,
                                        endRadius: 30
                                    )
                                )
                                .frame(width: 60, height: 60)
                            
                            Text(context.state.emoji)
                                .font(.system(size: 32))
                        }
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .trailing, spacing: 6) {
                        // Gradient score
                        Text("\(context.state.score)")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .blue, .purple],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        Text("POINTS")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                            .tracking(1.5)
                    }
                }
                
                DynamicIslandExpandedRegion(.center) {
                    // Empty for balance
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(spacing: 12) {
                        // Animated gradient progress bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                // Background track with gradient
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                .white.opacity(0.1),
                                                .white.opacity(0.2),
                                                .white.opacity(0.1)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(height: 8)
                                
                                // Animated progress fill
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                .purple,
                                                .blue,
                                                .cyan,
                                                .blue.opacity(0.8)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(
                                        width: max(geometry.size.width * CGFloat(context.state.score) / 100, 8),
                                        height: 8
                                    )
                                    .shadow(color: .blue.opacity(0.5), radius: 4, x: 0, y: 0)
                            }
                        }
                        .frame(height: 8)
                        
                        // Bottom info
                        HStack {
                            Text(context.attributes.title)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.7))
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(context.state.score >= 80 ? Color.green : context.state.score >= 50 ? Color.orange : Color.red)
                                    .frame(width: 6, height: 6)
                                    .shadow(color: context.state.score >= 80 ? .green : context.state.score >= 50 ? .orange : .red, radius: 3)
                                
                                Text("\(context.state.score)%")
                                    .font(.caption2)
                                    .foregroundStyle(.white.opacity(0.6))
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                
            } compactLeading: {
                // COMPACT VIEW - Left side with glow effect
                ZStack {
                    // Subtle glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.yellow.opacity(0.3), .clear],
                                center: .center,
                                startRadius: 5,
                                endRadius: 20
                            )
                        )
                        .frame(width: 30, height: 30)
                    
                    Text(context.state.emoji)
                        .font(.system(size: 20))
                }
                
            } compactTrailing: {
                // COMPACT VIEW - Right side with gradient
                HStack(spacing: 4) {
                    Text("\(context.state.score)")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.cyan, .blue],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    Text("pts")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(.white.opacity(0.6))
                        .offset(y: 2)
                }
                
            } minimal: {
                // MINIMAL VIEW - Just emoji with subtle glow
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.yellow.opacity(0.4), .clear],
                                center: .center,
                                startRadius: 3,
                                endRadius: 15
                            )
                        )
                        .frame(width: 20, height: 20)
                    
                    Text(context.state.emoji)
                        .font(.system(size: 14))
                }
            }
            .keylineTint(.purple)
        }
    }
}

