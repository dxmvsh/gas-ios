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
  /// Минимум одну цифру
  internal static var atLeast1Digit: String {
      return Text.localized("Localizable", "at least 1 digit")
  }
  /// Минимум одну прописную букву
  internal static var atLeast1LowercaseLetter: String {
      return Text.localized("Localizable", "at least 1 lowercase letter")
  }
  /// Минимум одну заглавную букву
  internal static var atLeast1UppercaseLetter: String {
      return Text.localized("Localizable", "at least 1 uppercase letter")
  }
  /// Не менее 8 символов
  internal static var atLeast8Chars: String {
      return Text.localized("Localizable", "at least 8 chars")
  }
  /// Одну из следующих знаков: .!@#$%^&*
  internal static var atLeastOneOfNextChars: String {
      return Text.localized("Localizable", "at least one of next chars")
  }
  /// Проверьте данные чтобы продолжить
  internal static var checkDataToContinue: String {
      return Text.localized("Localizable", "check data to continue")
  }
  /// Город
  internal static var city: String {
      return Text.localized("Localizable", "city")
  }
  /// Подтвердите пароль
  internal static var confirmPassword: String {
      return Text.localized("Localizable", "confirm password")
  }
  /// Продолжить
  internal static var `continue`: String {
      return Text.localized("Localizable", "continue")
  }
  /// Придумайте пароль
  internal static var createPassword: String {
      return Text.localized("Localizable", "create password")
  }
  /// Придумайте пароль для входа в приложение
  internal static var createPasswordForLogin: String {
      return Text.localized("Localizable", "create password for login")
  }
  /// Готово
  internal static var done: String {
      return Text.localized("Localizable", "done")
  }
  /// Эл.почта
  internal static var email: String {
      return Text.localized("Localizable", "email")
  }
  /// Подтверждение почты
  internal static var emailVerification: String {
      return Text.localized("Localizable", "email verification")
  }
  /// Введите 4-значный код подтверждения, который мы выслали на ваш email адрес %@
  internal static func enter4DigitCodeSentTo(_ p1: String) -> String {
    return Text.localized("Localizable", "enter 4 digit code sent to %@", p1)
  }
  /// Введите код
  internal static var enterCode: String {
      return Text.localized("Localizable", "enter code")
  }
  /// Введите номер телефона чтобы зарегистрироваться
  internal static var enterPhoneNumberToRegister: String {
      return Text.localized("Localizable", "enter phone number to register")
  }
  /// Введите пин-код для доступа к приложению
  internal static var enterPinCodeForAccess: String {
      return Text.localized("Localizable", "enter pin code for access")
  }
  /// Ф.И.О
  internal static var fio: String {
      return Text.localized("Localizable", "fio")
  }
  /// Получить код
  internal static var getCode: String {
      return Text.localized("Localizable", "get code")
  }
  /// Я согласен с
  internal static var iAgreeWith: String {
      return Text.localized("Localizable", "i agree with")
  }
  /// Неверный код
  internal static var invalidCode: String {
      return Text.localized("Localizable", "invalid code")
  }
  /// Номер лицевого счета
  internal static var personalAccountNumber: String {
      return Text.localized("Localizable", "personal account number")
  }
  /// Пин-код
  internal static var pinCode: String {
      return Text.localized("Localizable", "pin code")
  }
  /// Пожалуйста, введите электронную почту
  internal static var pleaseEnterEmail: String {
      return Text.localized("Localizable", "please enter email")
  }
  /// Пожалуйста, заполните поле верно
  internal static var pleaseEnterFieldCorrectly: String {
      return Text.localized("Localizable", "please enter field correctly")
  }
  /// Публичная оферта
  internal static var publicOffer: String {
      return Text.localized("Localizable", "public offer")
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
  /// Установите пин-код для быстрого доступа к приложению
  internal static var setPinCodeForFastAccess: String {
      return Text.localized("Localizable", "set pin code for fast access")
  }
  /// Установить вход по Face ID?
  internal static var setSignInByFaceid: String {
      return Text.localized("Localizable", "set sign in by faceid")
  }
  /// Установить
  internal static var setUp: String {
      return Text.localized("Localizable", "set up")
  }
  /// Вход по Face ID предоставит более защищенный доступ к приложению
  internal static var signInByFaceidIsSecure: String {
      return Text.localized("Localizable", "sign in by faceid is secure")
  }
  /// Войдите или зарегистрируйтесь чтобы продолжить
  internal static var signInOrSignUpToContinue: String {
      return Text.localized("Localizable", "sign in or sign up to continue")
  }
  /// Войти в приложение
  internal static var signInToApp: String {
      return Text.localized("Localizable", "sign in to app")
  }
  /// Пропустить
  internal static var skip: String {
      return Text.localized("Localizable", "skip")
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
  /// Условиями оферты
  internal static var withOfferConditions: String {
      return Text.localized("Localizable", "with offer conditions")
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
