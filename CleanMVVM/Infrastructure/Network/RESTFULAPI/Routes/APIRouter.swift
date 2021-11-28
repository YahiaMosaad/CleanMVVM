//
//  Routes.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
struct IdentifibleModel: APICodable {
    var id: Int
}

protocol APIRoute {
    var path: String { get }
    var method: APIClient.Method { get }
    var headers: [String: String]? { get }
    var requestModel: APICodable? { get }
//    var multipartForm: MultipartForm? { get }
    var needAuthorization: Bool { get }
    var guestToken: String? { get }
    var hasContent: Bool { get }
    /// Error message
    var errorMessage: String { get }
    var queryItems: [URLQueryItem]? { get }
    var isLocalized: Bool { get }
}

extension APIRoute {
    var headers: [String : String]? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
//    var multipartForm: MultipartForm? { nil }
    var needAuthorization: Bool { true }
    var hasContent: Bool { true }
    var errorMessage: String { TextKeys.Errors.defaultMessage }
    var queryItems: [URLQueryItem]? { nil }
    var isLocalized: Bool { false }
    var guestToken: String? { return nil }

    func request(configuration: APIConfiguration = APIConfiguration.default) -> URLRequest {
        guard let baseURL = configuration.baseURL else { fatalError(APIError.wrongBaseURL.rawValue) }
        
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = path
        queryItems.map {
            components.queryItems = $0
        }

        guard let requestURL = components.url else { fatalError(APIError.wrongBaseURL.rawValue) }
        var request = URLRequest(url: requestURL)
        configueHeaderOf(&request)
        request.httpMethod = method.rawValue.uppercased()
        if method != .get {
//            if let multipartForm = self.multipartForm {
//                request.httpBody = try? multipartForm.body()
//                request.setValue(multipartForm.contentType, forHTTPHeaderField: "Content-Type")
//            } else {
                requestModel.map {
                    request.httpBody = $0.jsonData
                    #if DEBUG
                    request.httpBody?.stringRepresentation.map {
                        print($0)
                    }
                    #endif
                }
//            }
        }
        
        return request
    }
    
    // MARK: - Private
    private func configueHeaderOf(_ request: inout URLRequest) {
        request.allHTTPHeaderFields = headers
        if needAuthorization {
            if let guestToken = self.guestToken {
                request.addValue(guestToken, forHTTPHeaderField: "authorization")
            } else {
//                KeychainManager.get(key: .token).map {
//                    request.addValue($0, forHTTPHeaderField: "authorization")
//                }
            }
        }
        
        if isLocalized {
            request.addValue(Locale.isArabiс ? "ar" : "en", forHTTPHeaderField: "x-locale")
        }
    }
}
