// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum Text {
  /// Адрес
  internal static var address: String {
      return Text.localized("Localizable", "address")
  }
  /// Проверьте данные чтобы продолжить
  internal static var checkDataToContinue: String {
      return Text.localized("Localizable", "check data to continue")
  }
  /// Город
  internal static var city: String {
      return Text.localized("Localizable", "city")
  }
  /// Продолжить
  internal static var `continue`: String {
      return Text.localized("Localizable", "continue")
  }
  /// Готово
  internal static var done: String {
      return Text.localized("Localizable", "done")
  }
  /// Эл.почта
  internal static var email: String {
      return Text.localized("Localizable", "email")
  }
  /// Введите код
  internal static var enterCode: String {
      return Text.localized("Localizable", "enter code")
  }
  /// Введите номер телефона чтобы зарегистрироваться
  internal static var enterPhoneNumberToRegister: String {
      return Text.localized("Localizable", "enter phone number to register")
  }
  /// Ф.И.О
  internal static var fio: String {
      return Text.localized("Localizable", "fio")
  }
  /// Получить код
  internal static var getCode: String {
      return Text.localized("Localizable", "get code")
  }
  /// Неверный код
  internal static var invalidCode: String {
      return Text.localized("Localizable", "invalid code")
  }
  /// Номер лицевого счета
  internal static var personalAccountNumber: String {
      return Text.localized("Localizable", "personal account number")
  }
  /// Пожалуйста, введите электронную почту
  internal static var pleaseEnterEmail: String {
      return Text.localized("Localizable", "please enter email")
  }
  /// Пожалуйста, заполните поле верно
  internal static var pleaseEnterFieldCorrectly: String {
      return Text.localized("Localizable", "please enter field correctly")
  }
  /// Регистрация
  internal static var registration: String {
      return Text.localized("Localizable", "registration")
  }
  /// Отправить повторно
  internal static var resendAgain: String {
      return Text.localized("Localizable", "resend again")
  }
  /// Отправить повторно через %@
  internal static func resendCodeAfter(_ p1: String) -> String {
    return Text.localized("Localizable", "resend code after %@", p1)
  }
  /// Войдите или зарегистрируйтесь чтобы продолжить
  internal static var signInOrSignUpToContinue: String {
      return Text.localized("Localizable", "sign in or sign up to continue")
  }
  /// Войти в приложение
  internal static var signInToApp: String {
      return Text.localized("Localizable", "sign in to app")
  }
  /// Регистрация пользователя
  internal static var userRegistration: String {
      return Text.localized("Localizable", "user registration")
  }
  /// Мы вам отправили SMS с кодом. Введите его.
  internal static var weSendYouSms: String {
      return Text.localized("Localizable", "we send you sms")
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
