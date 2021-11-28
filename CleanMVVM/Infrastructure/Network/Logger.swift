//
//  Logger.swift
//  CleanMVVM
//
//  Created by Yahia Mosaad on 05/11/2021.
//

import Foundation
protocol StringRawPresentable {
    var rawValue: String { get }
}


protocol Logable {
}
enum EventError: String, StringRawPresentable {
    case forceUpdateAPIUnexpectedResponse
    case getUserInformationAPIUnexpectedResponse
    case registerationScanningUnexpectedError
    case stuckInAlmostDoneForever
    case coreData
    

    
    // network
    case networkError
    
    // Device token
    case deviceTokenStoreFailed
    

    
    //system settings fetching error
    case systemSettingsFetchingFailure //it takes place when the application opens at home screen
    
    // FirebaseAuth
    case firebaseAuth
}
enum ErrorReason: String, StringRawPresentable {
    case unknownReason
    
    // network
    case unauthorized       // error 401: access token not found or not valid
    case wrongResource      // error 404: endpoint not found
    case noResponse         // response not delivered from server
    case transportError     // transport error
    case noResponseData     // no data to parse response
    case decodingError      // exception on decoding of received JSON to decodable model
  
}

extension Logable {
    func log<T: StringRawPresentable>(_ event: T,
                                      reason: ErrorReason,
                                      description: String? = nil)
    {
        let parameters = ["reason": reason.rawValue]
        log(event,
            reason: reason,
            parameters: description.flatMap { parameters.mergedWith(["description": $0]) } ?? parameters)
    }
    
    func log<T: StringRawPresentable>(_ event: T,
                                      reason: ErrorReason,
                                      parameters: [String: Any]?)
    {
        Logger.log(event,
                   parameters: ["reason": reason.rawValue].mergedWith(parameters))
    }
    
    func log<T: StringRawPresentable>(_ event: T, parameters:[String: Any]? = nil) {
        Logger.log(event, parameters: parameters)
    }
    
    func logToFacebook<T: StringRawPresentable>(_ event: T, valueToSum: Double? = nil, parameters:[String: Any]? = nil) {
//        Logger.logFacebook(event, valueToSum: valueToSum, parameters: parameters)
    }
}



struct Log: Logable {
    func networkError(reason: ErrorReason, parameters: [String: Any]?) {
        log(EventError.networkError,
            reason: reason,
            parameters: ["id": 1].mergedWith(parameters))
    }
    
    func firebaseAuthError(reason: ErrorReason, description: String?) {
        log(EventError.networkError,
            reason: reason,
            description: description)
    }
}
struct Logger {
    private static var defaultParameters: [String: Any] { [:] }
    
    static func log<T: StringRawPresentable>(_ event: T, parameters:[String: Any]? = nil) {
        // Log to Analitycs
        // Logging to console
        #if DEBUG
        print("Logged >>>>>>>>>>>>>>>>>>>>>")
        let type = event is EventError ? "error" : "info"
        print("  \(type): ")
        print("  parameters:\n \(String(describing: parameters))")
        print("<<<<<<<<<<<<<<<<<<<<<")
        #endif
    }
    
    static func log<T: StringRawPresentable>(_ event: T, reason: ErrorReason, description: String? = nil) {
        let parameters = ["reason": reason.rawValue]
        log(event, parameters: description.flatMap { parameters.mergedWith(["description": $0]) } ?? parameters )
    }
    

}
