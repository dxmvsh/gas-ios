// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum Text {
  /// Регистрация
  internal static var registration: String {
      return Text.localized("Localizable", "registration")
  }
  /// Войдите или зарегистрируйтесь чтобы продолжить
  internal static var signInOrSignUpToContinue: String {
      return Text.localized("Localizable", "sign in or sign up to continue")
  }
  /// Войти в приложение
  internal static var signInToApp: String {
      return Text.localized("Localizable", "sign in to app")
  }
  /// Добро пожаловать!
  internal static var welcome: String {
      return Text.localized("Localizable", "welcome")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension Text {
  private static func localized(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let currentLanguage = Language.storage?.currentLanguage ?? .system
    let identifierPrefix = String(currentLanguage.locale.identifier.prefix(2))
    let bundlePath = Bundle.main.path(forResource: identifierPrefix, ofType: "lproj")!
    let bundle = Bundle(path: bundlePath)!
    let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
    return String(format: format, locale: currentLanguage.locale, arguments: args)
  }
}

// MARK: - Language

protocol LanguageStorage: class {
    var currentLanguage: Language? { get set }
}

enum Language: String, CaseIterable {
    case russian, english, system
    enum Identifier {
        static let russia = "ru_RU"
        static let unitedStates = "en_US"
    }
    var locale: Locale {
        switch self {
        case .russian: return Locale(identifier: Identifier.russia)
        case .english: return Locale(identifier: Identifier.unitedStates)
        case .system: return Locale.current
        }
    }
    static var storage: LanguageStorage?
}