//
//  EncodableExtension.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Foundation

extension Encodable {
    /// Converts Codable-conformant class or struct instance into swift dictionary, if possible
    func toDict() -> [String: Any] {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(self)
            let dict: [String: Any] = try JSONSerialization.jsonObject(
                with: data, options: .mutableLeaves)
                as? [String: Any] ?? [String: Any]()
            return dict
        } catch {
            return [String: Any]()
        }
    }
}
