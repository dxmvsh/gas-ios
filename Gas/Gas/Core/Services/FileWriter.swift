//
//  FileWriter.swift
//  Gas
//
//  Created by Strong on 5/21/21.
//

import Foundation
import Moya

protocol FileWriterProtocol {
    func writeExportedFile(result: Result<Moya.Response, GeneralError>, completion: @escaping ResponseCompletion<URL>)
}

class FileWriter: FileWriterProtocol {
    func writeExportedFile(result: Result<Moya.Response, GeneralError>, completion: @escaping ResponseCompletion<URL>) {
        switch result {
        case .success(let response):
            guard let contentHeader = response.response?.headers.first(where: { $0.name == "Content-Disposition" })
                else {
                completion(.failure(.custom("error")))
                    return
            }
            let headerValueComponents = contentHeader.value.split(separator: "=").map(String.init)
            guard headerValueComponents.count > 1 else {
                completion(.failure(.custom("error")))
                return
            }
            let fileName = headerValueComponents[1]
                .replacingOccurrences(of: "\"", with: "")
                .replacingOccurrences(of: "/", with: "")
            guard let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(fileName)
                else {
                    completion(.failure(.custom("error")))
                    return
            }
            do {
                try response.data.write(to: filePath)
                completion(.success(filePath))
            } catch {
                completion(.failure(.custom("error: \(error)")))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
