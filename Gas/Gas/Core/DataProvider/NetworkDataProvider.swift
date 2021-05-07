//
//  NetworkDataProvider.swift
//  Gas
//
//  Created by Strong on 5/7/21.
//

import Moya
import Alamofire

enum GeneralError: Swift.Error {
    /// Indicates network is not reachable.
    case notReachable
    case timeout
    /// Indicates MoyaProvider errors.
    case moya(MoyaError)
    
    case api(ApiError)
    
    case custom(String)
    
    case internalServer
    
    var localizedDescription: String {
        switch self {
        case .moya(let error):
            return error.localizedDescription
        case .notReachable:
            return "Check internet connection and retry"
        case .api(let error):
            return error.getErrorText()
        case .custom(let text):
            return text
        case .internalServer:
            return "Internal server error"
        case .timeout:
            return "Requeset timeout"
        }
    }
    var errorData: ApiError? {
        switch self {
        case .api(let error):
            return error
        default:
            return nil
        }
    }
}

class NetworkDataProvider<Target: TargetType> {
    
    typealias Completion = (_ result: Result<Moya.Response, GeneralError>) -> Void
    
    // MARK: - Properties
    
    private let networkReachibilityChecker: NetworkReachabilityManager
    private var dataProvider: MoyaProvider<Target>
    
    // MARK: - Initializers
    
    public init(
        networkReachibilityChecker: NetworkReachabilityManager = NetworkReachabilityManager()!,
        endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
        callbackQueue: DispatchQueue? = nil,
        session: Session = Session(configuration: URLSessionConfiguration.default),
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        self.networkReachibilityChecker = networkReachibilityChecker
        dataProvider = MoyaProvider(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            callbackQueue: callbackQueue,
            session: session,
            plugins: plugins,
            trackInflights: trackInflights)
    }
    
    // MARK: - Actions
    
    func request(
        _ target: Target,
        callbackQueue: DispatchQueue? = nil,
        progress: Moya.ProgressBlock? = nil,
        completion: @escaping Completion
    ) {
        guard networkReachibilityChecker.isReachable else {
            guard let callbackQueue = callbackQueue else {
                progress?(ProgressResponse(progress: nil, response: nil))
//                alertManager.show()
                completion(.failure(.notReachable))
                return
            }
            callbackQueue.async { [weak self] in
                progress?(ProgressResponse(progress: nil, response: nil))
//                self?.alertManager.show()
                completion(.failure(.notReachable))
            }
            return
        }
        dataProvider.request(target, callbackQueue: callbackQueue, progress: progress) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let moyaError):
                if let code = moyaError.response?.statusCode,
                   code >= 500 {
                    completion(.failure(.internalServer))
                    return
                }
                switch moyaError {
                case .underlying(let error, _):
                    if error.asAFError?.isSessionTaskError ?? false {
                        completion(.failure(.timeout))
                        return
                    }
                default:
                    break
                }
                guard let apiError = ApiError.build(response: moyaError.response) else {
                    completion(.failure(.moya(moyaError)))
                    return
                }
                completion(.failure(.api(apiError)))
            }
        }
    }
}
