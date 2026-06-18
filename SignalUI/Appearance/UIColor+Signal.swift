//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//
// Ultra 2029 Design System — Futuristic dark-first color palette
//

import SignalServiceKit
public import SwiftUI
import UIKit

// MARK: - Custom Colors -

extension UIColor {
    fileprivate static func byUserInterfaceLevel(
        base: UIColor,
        elevated: UIColor,
    ) -> UIColor {
        UIColor { traitCollection in
            if traitCollection.userInterfaceLevel == .elevated {
                elevated
            } else {
                base
            }
        }
    }

    public static func byRGBHex(
        light: UInt32,
        lightHighContrast: UInt32? = nil,
        dark: UInt32,
        darkHighContrast: UInt32? = nil,
    ) -> UIColor {
        UIColor(
            light: UIColor(rgbHex: light),
            lightHighContrast: lightHighContrast != nil ? UIColor(rgbHex: lightHighContrast!) : nil,
            dark: UIColor(rgbHex: dark),
            darkHighContrast: darkHighContrast != nil ? UIColor(rgbHex: darkHighContrast!) : nil,
        )
    }

    public convenience init(
        light: UIColor,
        lightHighContrast: UIColor? = nil,
        dark: UIColor,
        darkHighContrast: UIColor? = nil,
    ) {
        self.init { traitCollection in
            switch (traitCollection.userInterfaceStyle, traitCollection.accessibilityContrast) {
            case (.dark, .high) where darkHighContrast != nil:
                darkHighContrast!
            case (.dark, _):
                dark
            case (_, .high) where lightHighContrast != nil:
                lightHighContrast!
            case (_, _):
                light
            }
        }
    }
}

// MARK: - UIKit

extension UIColor {
    public enum Signal {}
}

extension UIColor.Signal {

    // MARK: Accent — Ultra 2029 Neon Palette

    /// Primary accent: electric cyan in dark, deep electric blue in light
    public static var ultramarine: UIColor {
        UIColor.byRGBHex(
            light: 0x0077E6,
            lightHighContrast: 0x0055CC,
            dark: 0x00C8FF,
            darkHighContrast: 0x40DDFF,
        )
    }

    /// Danger / destructive: hot coral
    public static var red: UIColor {
        UIColor.byRGBHex(
            light: 0xFF2255,
            lightHighContrast: 0xCC0033,
            dark: 0xFF375F,
            darkHighContrast: 0xFF6B8A,
        )
    }

    /// Warning: solar amber
    public static var orange: UIColor {
        UIColor.byRGBHex(
            light: 0xFF8800,
            lightHighContrast: 0xCC5500,
            dark: 0xFFAA00,
            darkHighContrast: 0xFFCC44,
        )
    }

    /// Caution: plasma yellow
    public static var yellow: UIColor {
        UIColor.byRGBHex(
            light: 0xF5C400,
            lightHighContrast: 0xAA7700,
            dark: 0xFFDD00,
            darkHighContrast: 0xFFEE44,
        )
    }

    /// Success: electric mint
    public static var green: UIColor {
        UIColor.byRGBHex(
            light: 0x00BB55,
            lightHighContrast: 0x007733,
            dark: 0x00FF88,
            darkHighContrast: 0x44FFAA,
        )
    }

    /// Secondary accent: plasma violet
    public static var indigo: UIColor {
        UIColor.byRGBHex(
            light: 0x6244E8,
            lightHighContrast: 0x4422CC,
            dark: 0x9B5CF6,
            darkHighContrast: 0xBB88FF,
        )
    }

    public static var accent: UIColor { ultramarine }

    public static var link: UIColor { ultramarine }

    // MARK: Label — Holographic Text Colors

    /// Primary text: pure white in dark, near-black in light
    public static var label: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0A0A14),
            dark: UIColor(rgbHex: 0xF0F4FF),
        )
    }

    /// Secondary text: blue-tinted translucent
    public static var secondaryLabel: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x1A1A3A, alpha: 0.68),
            lightHighContrast: UIColor(rgbHex: 0x1A1A3A, alpha: 0.92),
            dark: UIColor(rgbHex: 0xC8DAFF, alpha: 0.70),
            darkHighContrast: UIColor(rgbHex: 0xC8DAFF, alpha: 0.85),
        )
    }

    /// Tertiary text: ghost blue
    public static var tertiaryLabel: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x2020AA, alpha: 0.28),
            lightHighContrast: UIColor(rgbHex: 0x2020AA, alpha: 0.48),
            dark: UIColor(rgbHex: 0x99BBFF, alpha: 0.30),
            darkHighContrast: UIColor(rgbHex: 0x99BBFF, alpha: 0.45),
        )
    }

    /// Quaternary text: barely-there indigo
    public static var quaternaryLabel: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x3030BB, alpha: 0.14),
            lightHighContrast: UIColor(rgbHex: 0x3030BB, alpha: 0.32),
            dark: UIColor(rgbHex: 0x7799FF, alpha: 0.15),
            darkHighContrast: UIColor(rgbHex: 0x7799FF, alpha: 0.28),
        )
    }

    /// Emphasis / error label: hot coral
    public static var emphasisLabel: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0xFF2255),
            lightHighContrast: UIColor(rgbHex: 0xCC0033),
            dark: UIColor(rgbHex: 0xFF375F),
            darkHighContrast: UIColor(rgbHex: 0xFF6B8A),
        )
    }

    /// Warning label: amber glow
    public static var warningLabel: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0xAA5500),
            dark: UIColor(rgbHex: 0xFFAA44),
        )
    }

    /// Official / verified: plasma violet
    public static var officialLabel: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x4422CC),
            dark: UIColor(rgbHex: 0xBB99FF),
        )
    }

    public static var officialLabelBackground: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x4422CC).withAlphaComponent(0.10),
            dark: UIColor(rgbHex: 0x3A2266),
        )
    }

    // MARK: Background — Deep Space

    /// Primary background: deep space in dark, ghost white in light
    public static var background: UIColor {
        UIColor.byUserInterfaceLevel(
            base: UIColor.byRGBHex(
                light: 0xF8F8FF,
                dark: 0x050509,
            ),
            elevated: UIColor.byRGBHex(
                light: 0xFFFFFF,
                dark: 0x0F0F1E,
                darkHighContrast: 0x1E1E33,
            ),
        )
    }

    /// Secondary background: cosmic navy in dark, pale blue-white in light
    public static var secondaryBackground: UIColor {
        guard #available(iOS 16.0, *) else {
            return .secondarySystemBackground
        }
        return UIColor.byUserInterfaceLevel(
            base: UIColor.byRGBHex(
                light: 0xEEEEFA,
                lightHighContrast: 0xE4E4F2,
                dark: 0x0C0C1A,
                darkHighContrast: 0x1C1C30,
            ),
            elevated: UIColor.byRGBHex(
                light: 0xEEEEFA,
                lightHighContrast: 0xE4E4F2,
                dark: 0x141428,
                darkHighContrast: 0x22223A,
            ),
        )
    }

    /// Tertiary background: deepest violet-black in dark
    public static var tertiaryBackground: UIColor {
        UIColor.byUserInterfaceLevel(
            base: UIColor.byRGBHex(
                light: 0xFFFFFF,
                dark: 0x0F0F22,
                darkHighContrast: 0x1E1E36,
            ),
            elevated: UIColor.byRGBHex(
                light: 0xFFFFFF,
                dark: 0x16163A,
                darkHighContrast: 0x252550,
            ),
        )
    }

    public static var secondaryUltramarineBackground: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0xC0DDFF),
            dark: UIColor(rgbHex: 0x001833),
        )
    }

    public static var backdrop: UIColor {
        UIColor(
            light: UIColor(white: 0, alpha: 0.24),
            dark: UIColor(white: 0, alpha: 0.72),
        )
    }

    // MARK: Grouped Background

    public static var groupedBackground: UIColor {
        guard #available(iOS 16.0, *) else {
            return .systemGroupedBackground
        }
        return UIColor.byUserInterfaceLevel(
            base: UIColor.byRGBHex(
                light: 0xEEEEFA,
                lightHighContrast: 0xE4E4F2,
                dark: 0x050509,
            ),
            elevated: UIColor.byRGBHex(
                light: 0xEEEEFA,
                lightHighContrast: 0xE4E4F2,
                dark: 0x0F0F1E,
                darkHighContrast: 0x1E1E33,
            ),
        )
    }

    public static var secondaryGroupedBackground: UIColor {
        UIColor.byUserInterfaceLevel(
            base: UIColor.byRGBHex(
                light: 0xFFFFFF,
                dark: 0x0F0F1E,
                darkHighContrast: 0x1E1E33,
            ),
            elevated: UIColor.byRGBHex(
                light: 0xFFFFFF,
                dark: 0x141428,
                darkHighContrast: 0x22223A,
            ),
        )
    }

    public static var tertiaryGroupedBackground: UIColor {
        guard #available(iOS 16.0, *) else {
            return .tertiarySystemGroupedBackground
        }
        return UIColor.byUserInterfaceLevel(
            base: UIColor.byRGBHex(
                light: 0xEEEEFA,
                lightHighContrast: 0xE4E4F2,
                dark: 0x141428,
                darkHighContrast: 0x22223A,
            ),
            elevated: UIColor.byRGBHex(
                light: 0xEEEEFA,
                lightHighContrast: 0xE4E4F2,
                dark: 0x1A1A3A,
                darkHighContrast: 0x2A2A50,
            ),
        )
    }

    // MARK: Fill — Translucent Layers

    public static var primaryFill: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0000AA, alpha: 0.08),
            lightHighContrast: UIColor(rgbHex: 0x0000AA, alpha: 0.18),
            dark: UIColor(rgbHex: 0x4488FF, alpha: 0.22),
            darkHighContrast: UIColor(rgbHex: 0x4488FF, alpha: 0.36),
        )
    }

    public static var secondaryFill: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0000AA, alpha: 0.06),
            lightHighContrast: UIColor(rgbHex: 0x0000AA, alpha: 0.14),
            dark: UIColor(rgbHex: 0x4488FF, alpha: 0.16),
            darkHighContrast: UIColor(rgbHex: 0x4488FF, alpha: 0.28),
        )
    }

    public static var tertiaryFill: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0000AA, alpha: 0.04),
            lightHighContrast: UIColor(rgbHex: 0x0000AA, alpha: 0.12),
            dark: UIColor(rgbHex: 0x6699FF, alpha: 0.12),
            darkHighContrast: UIColor(rgbHex: 0x6699FF, alpha: 0.22),
        )
    }

    public static var quaternaryFill: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0000AA, alpha: 0.02),
            lightHighContrast: UIColor(rgbHex: 0x0000AA, alpha: 0.08),
            dark: UIColor(rgbHex: 0x8899FF, alpha: 0.08),
            darkHighContrast: UIColor(rgbHex: 0x8899FF, alpha: 0.18),
        )
    }

    // MARK: Material — Glass Morphism Base

    /// Designed to be used on top of material (blur / glass) backgrounds.
    public enum MaterialBase {

        public static var fillPrimary: UIColor {
            UIColor(
                light: UIColor(white: 0, alpha: 0.16),
                dark: UIColor(rgbHex: 0x00C8FF, alpha: 0.22),
            )
        }

        public static var fillSecondary: UIColor {
            UIColor(
                light: UIColor(white: 0, alpha: 0.10),
                dark: UIColor(rgbHex: 0x00C8FF, alpha: 0.14),
            )
        }

        public static var fillTertiary: UIColor {
            UIColor(
                light: UIColor(white: 0, alpha: 0.06),
                dark: UIColor(rgbHex: 0x00C8FF, alpha: 0.08),
            )
        }

        public static var button: UIColor {
            UIColor(
                light: UIColor(white: 0, alpha: 0.10),
                dark: UIColor(rgbHex: 0x00C8FF, alpha: 0.18),
            )
        }
    }

    // MARK: Light

    /// To be used on top of neutral backgrounds
    /// (eg incoming message bubbles when no wallpaper).
    public enum LightBase {

        public static var fillPrimary: UIColor {
            UIColor(
                light: UIColor(white: 1, alpha: 1),
                dark: UIColor(white: 1, alpha: 0.52),
            )
        }

        public static var fillSecondary: UIColor {
            UIColor(
                light: UIColor(white: 1, alpha: 0.85),
                dark: UIColor(white: 1, alpha: 0.28),
            )
        }

        public static var fillTertiary: UIColor {
            UIColor(
                light: UIColor(white: 1, alpha: 0.65),
                dark: UIColor(white: 1, alpha: 0.18),
            )
        }

        public static var button: UIColor {
            UIColor(
                light: UIColor(white: 1, alpha: 0.85),
                dark: UIColor(white: 1, alpha: 0.22),
            )
        }
    }

    // MARK: Color

    /// To be used on top of any arbitrary color. Fixed across light/dark theme.
    public enum ColorBase {

        public static var labelPrimary: UIColor {
            UIColor(white: 1, alpha: 1)
        }

        public static var labelSecondary: UIColor {
            UIColor(white: 1, alpha: 0.82)
        }

        public static var labelTertiary: UIColor {
            UIColor(white: 1, alpha: 0.44)
        }

        public static var labelInverted: UIColor {
            UIColor(white: 0, alpha: 1)
        }

        public static var labelInvertedSecondary: UIColor {
            UIColor(white: 0, alpha: 0.72)
        }

        public static var fillPrimary: UIColor {
            UIColor(white: 1, alpha: 0.82)
        }

        public static var fillSecondary: UIColor {
            UIColor(white: 1, alpha: 0.72)
        }

        public static var fillTertiary: UIColor {
            UIColor(
                light: UIColor(white: 1, alpha: 0.62),
                dark: UIColor(white: 1, alpha: 0.50),
            )
        }

        public static var button: UIColor {
            UIColor(white: 1, alpha: 0.22)
        }
    }

    // MARK: Glass Tint (iOS 26+)

    @available(iOS 26, *)
    public static var glassBackgroundTint: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0055FF, alpha: 0.06),
            dark: UIColor(rgbHex: 0x00C8FF, alpha: 0.10),
        )
    }

    // MARK: Separator — Neon Hairlines

    public static var opaqueSeparator: UIColor {
        UIColor.byRGBHex(
            light: 0xD0D0E8,
            lightHighContrast: 0xAAAAAA,
            dark: 0x1E1E3A,
            darkHighContrast: 0x2E2E55,
        )
    }

    public static var transparentSeparator: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0000AA, alpha: 0.14),
            lightHighContrast: UIColor(rgbHex: 0x0000AA, alpha: 0.28),
            dark: UIColor(rgbHex: 0x00C8FF, alpha: 0.18),
            darkHighContrast: UIColor(rgbHex: 0x00C8FF, alpha: 0.32),
        )
    }

    // MARK: Ultra 2029 Exclusive Colors

    /// Neon glow tint for active/focused states
    public static var neonGlow: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0077E6, alpha: 0.15),
            dark: UIColor(rgbHex: 0x00C8FF, alpha: 0.25),
        )
    }

    /// Plasma violet glow — secondary interactive glow
    public static var plasmaGlow: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x6244E8, alpha: 0.12),
            dark: UIColor(rgbHex: 0x9B5CF6, alpha: 0.28),
        )
    }

    /// Deep space gradient start — for use in gradient backgrounds
    public static var cosmicStart: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0xF8F8FF),
            dark: UIColor(rgbHex: 0x050509),
        )
    }

    /// Deep space gradient end — cosmic navy
    public static var cosmicEnd: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0xEAEAFF),
            dark: UIColor(rgbHex: 0x0A0A1E),
        )
    }

    /// Holographic border — subtle neon edge for cards/bubbles
    public static var holographicBorder: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0055FF, alpha: 0.18),
            dark: UIColor(rgbHex: 0x00C8FF, alpha: 0.30),
        )
    }

    /// Outgoing message bubble: neon cyan gradient tint
    public static var outgoingBubble: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0x0077E6),
            dark: UIColor(rgbHex: 0x0099CC),
        )
    }

    /// Incoming message bubble: deep glass in dark, soft in light
    public static var incomingBubble: UIColor {
        UIColor(
            light: UIColor(rgbHex: 0xF0F0FF),
            dark: UIColor(rgbHex: 0x141430),
        )
    }
}

// MARK: - SwiftUI

extension Color {
    public enum Signal {}
}

extension Color.Signal {

    // MARK: Accent

    public static var ultramarine: Color {
        Color(UIColor.Signal.ultramarine)
    }

    public static var red: Color {
        Color(UIColor.Signal.red)
    }

    public static var orange: Color {
        Color(UIColor.Signal.orange)
    }

    public static var yellow: Color {
        Color(UIColor.Signal.yellow)
    }

    public static var green: Color {
        Color(UIColor.Signal.green)
    }

    public static var indigo: Color {
        Color(UIColor.Signal.indigo)
    }

    public static var accent: Color { ultramarine }

    public static var link: Color { ultramarine }

    // MARK: Label

    public static var label: Color {
        Color(UIColor.Signal.label)
    }

    public static var secondaryLabel: Color {
        Color(UIColor.Signal.secondaryLabel)
    }

    public static var tertiaryLabel: Color {
        Color(UIColor.Signal.tertiaryLabel)
    }

    public static var quaternaryLabel: Color {
        Color(UIColor.Signal.quaternaryLabel)
    }

    public static var emphasisLabel: Color {
        Color(UIColor.Signal.emphasisLabel)
    }

    public static var warningLabel: Color {
        Color(UIColor.Signal.warningLabel)
    }

    // MARK: Background

    public static var background: Color {
        Color(UIColor.Signal.background)
    }

    public static var secondaryBackground: Color {
        Color(UIColor.Signal.secondaryBackground)
    }

    public static var tertiaryBackground: Color {
        Color(UIColor.Signal.tertiaryBackground)
    }

    // MARK: Grouped Background

    public static var groupedBackground: Color {
        Color(UIColor.Signal.groupedBackground)
    }

    public static var secondaryGroupedBackground: Color {
        Color(UIColor.Signal.secondaryGroupedBackground)
    }

    public static var tertiaryGroupedBackground: Color {
        Color(UIColor.Signal.tertiaryGroupedBackground)
    }

    // MARK: Fill

    public static var primaryFill: Color {
        Color(UIColor.Signal.primaryFill)
    }

    public static var secondaryFill: Color {
        Color(UIColor.Signal.secondaryFill)
    }

    public static var tertiaryFill: Color {
        Color(UIColor.Signal.tertiaryFill)
    }

    public static var quaternaryFill: Color {
        Color(UIColor.Signal.quaternaryFill)
    }

    // MARK: Separator

    public static var opaqueSeparator: Color {
        Color(UIColor.Signal.opaqueSeparator)
    }

    public static var transparentSeparator: Color {
        Color(UIColor.Signal.transparentSeparator)
    }

    // MARK: Ultra 2029

    public static var neonGlow: Color {
        Color(UIColor.Signal.neonGlow)
    }

    public static var plasmaGlow: Color {
        Color(UIColor.Signal.plasmaGlow)
    }

    public static var holographicBorder: Color {
        Color(UIColor.Signal.holographicBorder)
    }

    public static var cosmicStart: Color {
        Color(UIColor.Signal.cosmicStart)
    }

    public static var cosmicEnd: Color {
        Color(UIColor.Signal.cosmicEnd)
    }

    public static var outgoingBubble: Color {
        Color(UIColor.Signal.outgoingBubble)
    }

    public static var incomingBubble: Color {
        Color(UIColor.Signal.incomingBubble)
    }
}
