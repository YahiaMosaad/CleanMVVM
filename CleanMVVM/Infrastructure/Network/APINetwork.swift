//
//  APINetwork.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation

class APINetwork {
    #if DEBUG
    static let logResponse = true
    #endif
    
    static func perform<T: Decodable>(route: APIRoute,
                                      responseModelType: T.Type,
                                      completion: ((APIClient.Result) -> ())? = nil)
    {
        let route = route
        
        let task = URLSession.shared.dataTask(with: route.request()) { (data, response, error) in
            if let error = error {
                completion?(APIClient.Result.failure(error))
            } else {
                self.handleResponseCode(of: response, forRoute: route, data: data, resultCompletion: completion) {
                    if let data = data {
                        #if DEBUG
                        if logResponse {
                            print("API REQUEST >>>>>>>>>>>>>>>>>>>>>")
                            print("\(route.request())")
                            print("\(route.method.rawValue.uppercased()): \(route.path)")
                            print("RESPONSE DATA -------------------")
                            data.stringRepresentation.map {
                                print($0)
                            }
                            print("<<<<<<<<<<<<<<<<<<<<<")
                        }
                        #endif
                        do {
                            let model: T = try data.decode()
                            completion?(APIClient.Result.success(model))
                        } catch let error {
                            
                            print("\((error as! DecodingError))")
                            
                            completion?(APIClient.Result.failure(error))
                            #if DEBUG
                            if logResponse {
                                print("RESPONSE ERROR ------------------")
                                print(error)
                                print("--------------------")
                            }
                            #endif
                            }
                    } else {
                        completion?(APIClient.Result.failure(TextError(text: route.errorMessage)))
                    }
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: - Private
    private static  func handleResponseCode(of response: URLResponse?,
                                            forRoute route: APIRoute,
                                            data: Data?,
                                            resultCompletion: ((APIClient.Result) -> ())? = nil,
                                            validationCompletion: () -> Void)
    {
        if let code = response?.code {
            if route.needAuthorization && code == 401 {
                resultCompletion?(APIClient.Result.failure(APIError.unauthorized))
            } else if code == 204 {
                resultCompletion?(APIClient.Result.success(true))
            } else if code == 403 {
                DispatchQueue.main.async {
//                    UserState.shared.isDeactivated = true
                    resultCompletion?(APIClient.Result.failure(APIError.generalError))
                }
            } else if code == 404 {
                resultCompletion?(APIClient.Result.failure(TextError(text: route.errorMessage)))
            } else if code == 409 {
                resultCompletion?(APIClient.Result.failure(APIError.generalError))
            } else {
                validationCompletion()
            }
            if code != 403 {
                DispatchQueue.main.async {
//                    if UserState.shared.isDeactivated {
//                        UserState.shared.isDeactivated = false
//                    }
                }
            }
        } else {
            resultCompletion?(APIClient.Result.failure(TextError(text: route.errorMessage)))
        }
    }
}

// MARK: - Logging
//extension APINetwork: Logable {
//
//    private static func loggingParameters(response: URLResponse?, responseData: Data?) -> [String: Any] {
//        return self.loggingParameters(response: response, description: responseData?.stringRepresentation)
//    }
//
//    private static func loggingParameters(response: URLResponse?, description: String? = nil) -> [String: Any] {
//        let url = response?.url
//        var parameters: [String : Any] = [
//            "url": response?.url?.fullPath ?? "",
//            "description": description ?? ""
//            ]
//        url?.queryItems?.forEach {
//            let characterSet = CharacterSet.letters.union(CharacterSet.letters).union(CharacterSet(charactersIn: "_"))
//            let name = String($0.name.unicodeScalars.filter(characterSet.contains))
//            if nil == parameters[name] {
//                parameters[name] = $0.value ?? ""
//            } else {
//                parameters[name] = [parameters[name] as? String, String(describing: $0.value ?? "")].compactMap { $0 }.joined(separator: ", ")
//            }
//        }
//
//        return parameters
//    }
//}
