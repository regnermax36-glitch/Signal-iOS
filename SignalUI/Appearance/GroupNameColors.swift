//
// Copyright 2021 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

import Foundation
public import LibSignalClient
public import SignalServiceKit
import UIKit

// MARK: -

/// Represents the "message sender" to "group name color" mapping
/// for a given CVC load.
public struct GroupNameColors {
    private let colorMap: [Aci: UIColor]
    private let defaultColor: UIColor

    public func color(for aci: Aci?) -> UIColor {
        return aci.flatMap({ colorMap[$0] }) ?? defaultColor
    }

    fileprivate static var defaultColors: GroupNameColors {
        GroupNameColors(colorMap: [:], defaultColor: Theme.primaryTextColor)
    }

    public static func forThread(_ thread: TSThread) -> GroupNameColors {
        guard let groupThread = thread as? TSGroupThread else {
            return .defaultColors
        }
        let values = Self.groupNameColorValues
        let isDarkThemeEnabled = Theme.isDarkThemeEnabled
        var colorMap = [Aci: UIColor]()
        let groupMembers = groupThread.groupMembership.fullMembers
            .compactMap(\.aci).sorted(by: <)
        for (index, aci) in groupMembers.enumerated() {
            colorMap[aci] = values[index % values.count].color(isDarkThemeEnabled: isDarkThemeEnabled)
        }
        let defaultColor = values[groupMembers.endIndex % values.count].color(isDarkThemeEnabled: isDarkThemeEnabled)
        return GroupNameColors(colorMap: colorMap, defaultColor: defaultColor)
    }

    private static var defaultGroupNameColor: UIColor {
        let isDarkThemeEnabled = Theme.isDarkThemeEnabled
        return Self.groupNameColorValues.first!.color(isDarkThemeEnabled: isDarkThemeEnabled)
    }

    fileprivate struct GroupNameColorValue {
        let lightTheme: UIColor
        let darkTheme: UIColor

        func color(isDarkThemeEnabled: Bool) -> UIColor {
            isDarkThemeEnabled ? darkTheme : lightTheme
        }
    }

    // Ultra 2029 — Neon spectrum group name colors
    fileprivate static let groupNameColorValues: [GroupNameColorValue] = [
        // Electric cyan
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x0077CC),
            darkTheme: UIColor(rgbHex: 0x00C8FF),
        ),
        // Electric mint
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x00995C),
            darkTheme: UIColor(rgbHex: 0x00FF88),
        ),
        // Plasma violet
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x7722CC),
            darkTheme: UIColor(rgbHex: 0xBB66FF),
        ),
        // Hot coral
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xCC1144),
            darkTheme: UIColor(rgbHex: 0xFF375F),
        ),
        // Steel blue
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x445566),
            darkTheme: UIColor(rgbHex: 0x88AABB),
        ),
        // Neon rose
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xCC0055),
            darkTheme: UIColor(rgbHex: 0xFF44AA),
        ),
        // Electric blue
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x1144EE),
            darkTheme: UIColor(rgbHex: 0x5588FF),
        ),
        // Cyan teal
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x006688),
            darkTheme: UIColor(rgbHex: 0x00CCDD),
        ),
        // Solar amber
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xAA6600),
            darkTheme: UIColor(rgbHex: 0xFFAA22),
        ),
        // Neon pink
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xBB0066),
            darkTheme: UIColor(rgbHex: 0xFF44BB),
        ),
        // Indigo plasma
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x5511DD),
            darkTheme: UIColor(rgbHex: 0x9966FF),
        ),
        // Lime neon
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x447700),
            darkTheme: UIColor(rgbHex: 0x88EE00),
        ),
        // Vermillion
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xCC2200),
            darkTheme: UIColor(rgbHex: 0xFF6655),
        ),
        // Emerald
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x007744),
            darkTheme: UIColor(rgbHex: 0x00EE88),
        ),
        // Periwinkle
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x3344EE),
            darkTheme: UIColor(rgbHex: 0x8899FF),
        ),
        // Saffron
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x997700),
            darkTheme: UIColor(rgbHex: 0xEEBB00),
        ),
        // Sea green
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x007766),
            darkTheme: UIColor(rgbHex: 0x00DDBB),
        ),
        // Ultraviolet
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x8800BB),
            darkTheme: UIColor(rgbHex: 0xCC55FF),
        ),
        // Yellow-green
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x558800),
            darkTheme: UIColor(rgbHex: 0xAADD00),
        ),
        // Magenta
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xBB0099),
            darkTheme: UIColor(rgbHex: 0xFF44EE),
        ),
        // Tangerine
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xCC5500),
            darkTheme: UIColor(rgbHex: 0xFF8833),
        ),
        // Spring green
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x008833),
            darkTheme: UIColor(rgbHex: 0x22DD66),
        ),
        // Lavender
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x6633EE),
            darkTheme: UIColor(rgbHex: 0xAA88FF),
        ),
        // Gold
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x886600),
            darkTheme: UIColor(rgbHex: 0xDDAA00),
        ),
        // Crimson
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xCC0022),
            darkTheme: UIColor(rgbHex: 0xFF4466),
        ),
        // Chartreuse
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x558800),
            darkTheme: UIColor(rgbHex: 0x88CC00),
        ),
        // Purple
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x9900CC),
            darkTheme: UIColor(rgbHex: 0xDD55FF),
        ),
        // Jade
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x226633),
            darkTheme: UIColor(rgbHex: 0x44BB66),
        ),
        // Royal blue
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x1155CC),
            darkTheme: UIColor(rgbHex: 0x6699FF),
        ),
        // Ochre
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x886600),
            darkTheme: UIColor(rgbHex: 0xCCAA00),
        ),
        // Aqua
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x007799),
            darkTheme: UIColor(rgbHex: 0x00CCEE),
        ),
        // Violet
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x5533EE),
            darkTheme: UIColor(rgbHex: 0x9988FF),
        ),
        // Moss
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x556600),
            darkTheme: UIColor(rgbHex: 0x99BB00),
        ),
        // Cerulean
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x007799),
            darkTheme: UIColor(rgbHex: 0x00BBDD),
        ),
        // Fuchsia
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0xAA0099),
            darkTheme: UIColor(rgbHex: 0xFF33CC),
        ),
        // Forest
        GroupNameColorValue(
            lightTheme: UIColor(rgbHex: 0x226622),
            darkTheme: UIColor(rgbHex: 0x44BB44),
        ),
    ]
}
