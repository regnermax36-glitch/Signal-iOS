//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//
// Ultra 2029 Design System — Glass morphism, neon glow, holographic effects
//

import SwiftUI
import UIKit

// MARK: - UIKit Glass Morphism

public extension UIView {

    /// Applies Ultra 2029 glass morphism: frosted blur + neon border + subtle glow
    func applyUltra2029Glass(
        cornerRadius: CGFloat = 20,
        blurStyle: UIBlurEffect.Style = .systemUltraThinMaterial,
        borderColor: UIColor = UIColor.Signal.holographicBorder,
        borderWidth: CGFloat = 0.75
    ) {
        backgroundColor = .clear
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous
        clipsToBounds = false

        // Blur view
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.layer.cornerRadius = cornerRadius
        blur.layer.cornerCurve = .continuous
        blur.clipsToBounds = true
        insertSubview(blur, at: 0)
        NSLayoutConstraint.activate([
            blur.leadingAnchor.constraint(equalTo: leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: trailingAnchor),
            blur.topAnchor.constraint(equalTo: topAnchor),
            blur.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        // Neon border
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth

        // Outer glow shadow
        layer.shadowColor = UIColor.Signal.ultramarine.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    /// Applies a neon glow halo around the view
    func applyNeonGlow(
        color: UIColor = UIColor.Signal.ultramarine,
        radius: CGFloat = 10,
        opacity: Float = 0.45
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = .zero
    }

    /// Removes any neon glow
    func removeNeonGlow() {
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
    }

    /// Applies Ultra 2029 card style: elevated dark surface with neon border
    func applyUltra2029Card(cornerRadius: CGFloat = 16) {
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous
        clipsToBounds = true
        backgroundColor = UIColor.Signal.secondaryGroupedBackground
        layer.borderColor = UIColor.Signal.holographicBorder.cgColor
        layer.borderWidth = 0.5
    }
}

// MARK: - UIView Holographic Gradient Overlay

public final class HolographicGradientView: UIView {

    private let gradientLayer = CAGradientLayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    private func setupGradient() {
        gradientLayer.type = .axial
        gradientLayer.colors = [
            UIColor(rgbHex: 0x00C8FF, alpha: 0.0).cgColor,
            UIColor(rgbHex: 0x9B5CF6, alpha: 0.06).cgColor,
            UIColor(rgbHex: 0x00FF88, alpha: 0.0).cgColor,
        ]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.addSublayer(gradientLayer)
        isUserInteractionEnabled = false
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    /// Animate the holographic shimmer
    public func startShimmer() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.5, 1.0]
        animation.toValue = [0.5, 1.0, 1.5]
        animation.duration = 3.0
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        gradientLayer.add(animation, forKey: "shimmer")
    }

    public func stopShimmer() {
        gradientLayer.removeAnimation(forKey: "shimmer")
    }
}

// MARK: - Neon Bubble Background View

public final class NeonBubbleBackgroundView: UIView {

    private let blurView: UIVisualEffectView
    private let tintView = UIView()
    private let borderLayer = CAShapeLayer()

    public enum Style {
        case outgoing   // electric cyan
        case incoming   // deep glass
    }

    private let style: Style

    public init(style: Style) {
        self.style = style

        let blurStyle: UIBlurEffect.Style = style == .outgoing
            ? .systemThinMaterial
            : .systemUltraThinMaterial
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupView() {
        backgroundColor = .clear
        clipsToBounds = false

        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.clipsToBounds = true
        addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        tintView.translatesAutoresizingMaskIntoConstraints = false
        tintView.clipsToBounds = true
        addSubview(tintView)
        NSLayoutConstraint.activate([
            tintView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tintView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tintView.topAnchor.constraint(equalTo: topAnchor),
            tintView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        switch style {
        case .outgoing:
            tintView.backgroundColor = UIColor.Signal.outgoingBubble.withAlphaComponent(0.72)
            // Outgoing: subtle neon glow
            layer.shadowColor = UIColor.Signal.ultramarine.cgColor
            layer.shadowOpacity = 0.30
            layer.shadowRadius = 10
            layer.shadowOffset = CGSize(width: 0, height: 3)
        case .incoming:
            tintView.backgroundColor = UIColor.Signal.incomingBubble.withAlphaComponent(0.85)
            layer.shadowColor = UIColor(rgbHex: 0x9B5CF6).cgColor
            layer.shadowOpacity = 0.15
            layer.shadowRadius = 6
            layer.shadowOffset = CGSize(width: 0, height: 2)
        }

        layer.addSublayer(borderLayer)
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.Signal.holographicBorder.cgColor
        borderLayer.lineWidth = 0.75
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = min(bounds.height / 2, 20)
        blurView.layer.cornerRadius = radius
        blurView.layer.cornerCurve = .continuous
        tintView.layer.cornerRadius = radius
        tintView.layer.cornerCurve = .continuous
        borderLayer.frame = bounds
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    }
}

// MARK: - SwiftUI Extensions

public extension View {

    /// Ultra 2029 glass card modifier
    func ultra2029Glass(
        cornerRadius: CGFloat = 20,
        borderOpacity: Double = 0.30
    ) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(Color.Signal.holographicBorder.opacity(borderOpacity), lineWidth: 0.75)
                    )
            )
            .shadow(color: Color.Signal.ultramarine.opacity(0.22), radius: 12, x: 0, y: 4)
    }

    /// Neon glow halo effect
    func neonGlow(
        color: Color = Color.Signal.ultramarine,
        radius: CGFloat = 8,
        opacity: Double = 0.40
    ) -> some View {
        self
            .shadow(color: color.opacity(opacity), radius: radius, x: 0, y: 0)
            .shadow(color: color.opacity(opacity * 0.5), radius: radius * 2, x: 0, y: 0)
    }

    /// Holographic shimmer gradient overlay
    func holographicShimmer() -> some View {
        self.overlay(
            LinearGradient(
                colors: [
                    Color(UIColor(rgbHex: 0x00C8FF, alpha: 0.0)),
                    Color(UIColor(rgbHex: 0x9B5CF6, alpha: 0.05)),
                    Color(UIColor(rgbHex: 0x00FF88, alpha: 0.0)),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .allowsHitTesting(false)
        )
    }

    /// Ultra 2029 card style
    func ultra2029Card(cornerRadius: CGFloat = 16) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.Signal.secondaryGroupedBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(Color.Signal.holographicBorder, lineWidth: 0.5)
                    )
            )
    }
}

// MARK: - Ultra 2029 Cosmic Background View

/// Full-screen animated cosmic gradient background for launch / onboarding screens
public final class CosmicBackgroundView: UIView {

    private let gradientLayer = CAGradientLayer()
    private let particleLayer = CAEmitterLayer()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBackground()
    }

    private func setupBackground() {
        gradientLayer.type = .radial
        gradientLayer.colors = [
            UIColor(rgbHex: 0x0A0A1E).cgColor,
            UIColor(rgbHex: 0x050509).cgColor,
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)

        let anim = CABasicAnimation(keyPath: "colors")
        anim.fromValue = [
            UIColor(rgbHex: 0x0A0A1E).cgColor,
            UIColor(rgbHex: 0x050509).cgColor,
        ]
        anim.toValue = [
            UIColor(rgbHex: 0x0E0A22).cgColor,
            UIColor(rgbHex: 0x07050F).cgColor,
        ]
        anim.duration = 8.0
        anim.repeatCount = .infinity
        anim.autoreverses = true
        anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        gradientLayer.add(anim, forKey: "cosmicPulse")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

// MARK: - Ultra 2029 Neon Separator

/// A pixel-thin neon separator line for use between list sections
public final class NeonSeparatorView: UIView {

    public init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.Signal.transparentSeparator
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - SwiftUI Neon Button Style

public struct NeonButtonStyle: ButtonStyle {
    var color: Color = Color.Signal.ultramarine

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(
                Capsule(style: .continuous)
                    .fill(color)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(color.opacity(0.6), lineWidth: 1)
                    )
            )
            .shadow(color: color.opacity(configuration.isPressed ? 0.15 : 0.45), radius: configuration.isPressed ? 4 : 12, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

// MARK: - SwiftUI Ghost Button Style

public struct GhostButtonStyle: ButtonStyle {
    var color: Color = Color.Signal.ultramarine

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .foregroundStyle(color)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(
                Capsule(style: .continuous)
                    .fill(color.opacity(0.08))
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(color.opacity(0.40), lineWidth: 0.75)
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.65), value: configuration.isPressed)
    }
}

// MARK: - UIColor hex convenience (internal)

private extension UIColor {
    convenience init(rgbHex: UInt32, alpha: CGFloat = 1.0) {
        let r = CGFloat((rgbHex >> 16) & 0xFF) / 255
        let g = CGFloat((rgbHex >> 8) & 0xFF) / 255
        let b = CGFloat(rgbHex & 0xFF) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
