import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ============================================================
// App Color Tokens — mirrors your CSS custom properties exactly
// ============================================================
abstract class AppTokens {
  // --- Light ---
  static const background = Color(0xFFF9F9F9);
  static const foreground = Color(0xFF3A3A3A);
  static const card = Color(0xFFFFFFFF);
  static const cardForeground = Color(0xFF3A3A3A);
  static const popover = Color(0xFFFFFFFF);
  static const popoverForeground = Color(0xFF3A3A3A);
  static const primary = Color(0xFF606060);
  static const primaryForeground = Color(0xFFF0F0F0);
  static const secondary = Color(0xFFDEDEDE);
  static const secondaryForeground = Color(0xFF3A3A3A);
  static const muted = Color(0xFFE3E3E3);
  static const mutedForeground = Color(0xFF505050);
  static const accent = Color(0xFFF3EAC8); // warm cream-yellow ✨
  static const accentForeground = Color(0xFF5D4037); // deep brown
  static const destructive = Color(0xFFC87A7A);
  static const destructiveForeground = Color(0xFFFFFFFF);
  static const border = Color(0xFF747272);
  static const input = Color(0xFFFFFFFF);
  static const ring = Color(0xFFA0A0A0);
  static const sidebar = Color(0xFFF0F0F0);
  static const sidebarForeground = Color(0xFF3A3A3A);
  static const sidebarPrimary = Color(0xFF606060);
  static const sidebarPrimaryForeground = Color(0xFFF0F0F0);
  static const sidebarAccent = Color(0xFFF3EAC8);
  static const sidebarAccentForeground = Color(0xFF5D4037);
  static const sidebarBorder = Color(0xFFC0C0C0);
  static const sidebarRing = Color(0xFFA0A0A0);

  // --- Dark ---
  static const darkBackground = Color(0xFF2B2B2B);
  static const darkForeground = Color(0xFFDCDCDC);
  static const darkCard = Color(0xFF333333);
  static const darkCardForeground = Color(0xFFDCDCDC);
  static const darkPopover = Color(0xFF333333);
  static const darkPopoverForeground = Color(0xFFDCDCDC);
  static const darkPrimary = Color(0xFFB0B0B0);
  static const darkPrimaryForeground = Color(0xFF2B2B2B);
  static const darkSecondary = Color(0xFF5A5A5A);
  static const darkSecondaryForeground = Color(0xFFC0C0C0);
  static const darkMuted = Color(0xFF454545);
  static const darkMutedForeground = Color(0xFFA0A0A0);
  static const darkAccent = Color(0xFFE0E0E0);
  static const darkAccentForeground = Color(0xFF333333);
  static const darkDestructive = Color(0xFFD9AFAF);
  static const darkDestructiveForeground = Color(0xFF2B2B2B);
  static const darkBorder = Color(0xFF4F4F4F);
  static const darkInput = Color(0xFF333333);
  static const darkRing = Color(0xFFC0C0C0);
  static const darkSidebar = Color(0xFF212121);
  static const darkSidebarForeground = Color(0xFFDCDCDC);
  static const darkSidebarPrimary = Color(0xFFB0B0B0);
  static const darkSidebarPrimaryForeground = Color(0xFF212121);
  static const darkSidebarAccent = Color(0xFFE0E0E0);
  static const darkSidebarAccentForeground = Color(0xFF333333);
  static const darkSidebarBorder = Color(0xFF4F4F4F);
  static const darkSidebarRing = Color(0xFFC0C0C0);

  // --- Chart colors (light) ---
  static const chart1 = Color(0xFF333333);
  static const chart2 = Color(0xFF555555);
  static const chart3 = Color(0xFF777777);
  static const chart4 = Color(0xFF999999);
  static const chart5 = Color(0xFFBBBBBB);

  // --- Chart colors (dark) ---
  static const darkChart1 = Color(0xFFEFEFEF);
  static const darkChart2 = Color(0xFFD0D0D0);
  static const darkChart3 = Color(0xFFB0B0B0);
  static const darkChart4 = Color(0xFF909090);
  static const darkChart5 = Color(0xFF707070);
}

// ============================================================
// Light ShadColorScheme
// ============================================================
class AppLightColorScheme extends ShadColorScheme {
  const AppLightColorScheme()
    : super(
        background: AppTokens.background,
        foreground: AppTokens.foreground,
        card: AppTokens.card,
        cardForeground: AppTokens.cardForeground,
        popover: AppTokens.popover,
        popoverForeground: AppTokens.popoverForeground,
        primary: AppTokens.primary,
        primaryForeground: AppTokens.primaryForeground,
        secondary: AppTokens.secondary,
        secondaryForeground: AppTokens.secondaryForeground,
        muted: AppTokens.muted,
        mutedForeground: AppTokens.mutedForeground,
        accent: AppTokens.accent,
        accentForeground: AppTokens.accentForeground,
        destructive: AppTokens.destructive,
        destructiveForeground: AppTokens.destructiveForeground,
        border: AppTokens.border,
        input: AppTokens.input,
        ring: AppTokens.ring,
        selection: AppTokens.accent,
      );
}

// ============================================================
// Dark ShadColorScheme
// ============================================================
class AppDarkColorScheme extends ShadColorScheme {
  const AppDarkColorScheme()
    : super(
        background: AppTokens.darkBackground,
        foreground: AppTokens.darkForeground,
        card: AppTokens.darkCard,
        cardForeground: AppTokens.darkCardForeground,
        popover: AppTokens.darkPopover,
        popoverForeground: AppTokens.darkPopoverForeground,
        primary: AppTokens.darkPrimary,
        primaryForeground: AppTokens.darkPrimaryForeground,
        secondary: AppTokens.darkSecondary,
        secondaryForeground: AppTokens.darkSecondaryForeground,
        muted: AppTokens.darkMuted,
        mutedForeground: AppTokens.darkMutedForeground,
        accent: AppTokens.darkAccent,
        accentForeground: AppTokens.darkAccentForeground,
        destructive: AppTokens.darkDestructive,
        destructiveForeground: AppTokens.darkDestructiveForeground,
        border: AppTokens.darkBorder,
        input: AppTokens.darkInput,
        ring: AppTokens.darkRing,
        selection: AppTokens.darkSecondary,
      );
}

// ============================================================
// Optional: Flutter ThemeData for non-shadcn Material widgets
// Keeps Scaffold, AppBar, TextField, etc. visually consistent.
// ============================================================
abstract class AppThemeData {
  static ThemeData light() => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppTokens.background,
    colorScheme: ColorScheme.light(
      surface: AppTokens.card,
      onSurface: AppTokens.cardForeground,
      primary: AppTokens.primary,
      onPrimary: AppTokens.primaryForeground,
      secondary: AppTokens.secondary,
      onSecondary: AppTokens.secondaryForeground,
      error: AppTokens.destructive,
      onError: AppTokens.destructiveForeground,
      outline: AppTokens.border,
      surfaceContainerHighest: AppTokens.muted,
    ),
    dividerColor: AppTokens.border,
    cardColor: AppTokens.card,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppTokens.input,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppTokens.border),
        borderRadius: BorderRadius.circular(10), // 0.625rem ≈ 10px
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTokens.border),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTokens.ring, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static ThemeData dark() => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppTokens.darkBackground,
    colorScheme: ColorScheme.dark(
      surface: AppTokens.darkCard,
      onSurface: AppTokens.darkCardForeground,
      primary: AppTokens.darkPrimary,
      onPrimary: AppTokens.darkPrimaryForeground,
      secondary: AppTokens.darkSecondary,
      onSecondary: AppTokens.darkSecondaryForeground,
      error: AppTokens.darkDestructive,
      onError: AppTokens.darkDestructiveForeground,
      outline: AppTokens.darkBorder,
      surfaceContainerHighest: AppTokens.darkMuted,
    ),
    dividerColor: AppTokens.darkBorder,
    cardColor: AppTokens.darkCard,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppTokens.darkInput,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppTokens.darkBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTokens.darkBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppTokens.darkRing, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
