// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let checkboxEmpty = ImageAsset(name: "checkbox_empty")
  internal static let checkboxSelected = ImageAsset(name: "checkbox_selected")
  internal static let nbBackIcon = ImageAsset(name: "nb_back_icon")
  internal static let nbSupportIcon = ImageAsset(name: "nb_support_icon")
  internal static let iconAccount = ImageAsset(name: "icon_account")
  internal static let iconAccountSelected = ImageAsset(name: "icon_account_selected")
  internal static let iconHome = ImageAsset(name: "icon_home")
  internal static let iconHomeSelected = ImageAsset(name: "icon_home_selected")
  internal static let iconReceipt = ImageAsset(name: "icon_receipt")
  internal static let iconScan = ImageAsset(name: "icon_scan")
  internal static let iconSettings = ImageAsset(name: "icon_settings")
  internal static let iconSettingsSelected = ImageAsset(name: "icon_settings_selected")
  internal static let backspace = ImageAsset(name: "backspace")
  internal static let biometry = ImageAsset(name: "biometry")
  internal static let checkMark = ImageAsset(name: "checkMark")
  internal static let checkbox = ImageAsset(name: "checkbox")
  internal static let iconArrowDown = ImageAsset(name: "icon_arrow_down")
  internal static let iconClear = ImageAsset(name: "icon_clear")
  internal static let iconEyeClosed = ImageAsset(name: "icon_eye_closed")
  internal static let iconEyeOpen = ImageAsset(name: "icon_eye_open")
  internal static let iconNext = ImageAsset(name: "icon_next")
  internal static let iconScanSmall = ImageAsset(name: "icon_scan_small")
  internal static let icondownload = ImageAsset(name: "icondownload")
  internal static let infoIcon = ImageAsset(name: "info_icon")
  internal static let initialImage = ImageAsset(name: "initial_image")
  internal static let lineGraph = ImageAsset(name: "line_graph")
  internal static let rpFail = ImageAsset(name: "rp_fail")
  internal static let rpSuccess = ImageAsset(name: "rp_success")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = Color(asset: self)

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
