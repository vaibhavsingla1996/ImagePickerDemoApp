//
//  KNLogs.swift
//  HYTORC
//
//  Created by Pratibha Gupta on 29/01/18.
//  Copyright © 2018 Pratibha Gupta. All rights reserved.
//

import Foundation

enum LogStyle {
    case withResponseData
    case withoutResponseData
    case withResponseHeader
    case withoutResponseHeader
}


struct KNLogs {

    static let logStyleResponseData: LogStyle = .withoutResponseData
    static let logStyleResponseHeader: LogStyle = .withoutResponseHeader

    //MARK: - Logging
    static func logDivider() {
        print("---------------------")
    }

    static func logError(_ error: NSError) {
        logDivider()

        print("Error: \(error.localizedDescription)")

        if let reason = error.localizedFailureReason {
            print("Reason: \(reason)")
        }

        if let suggestion = error.localizedRecoverySuggestion {
            print("Suggestion: \(suggestion)")
        }
    }

    static func logRequest(_ request: URLRequest) {
        self.logDivider()

        if let url = request.url?.absoluteString {
            print("Request: \(request.httpMethod!) \(url)")
        }

        if let headers = request.allHTTPHeaderFields {
            self.logHeaders(headers as [String : AnyObject])
        }
        if let data = request.httpBody {
            self.logHttpBody(data as Data)
        }
    }

    static func logResponse(_ response: URLResponse, data: Data? = nil) {
        self.logDivider()

        if let url = response.url?.absoluteString {
            print("Response: \(url)")
        }

        if let httpResponse = response as? HTTPURLResponse {
            let localisedStatus = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode).capitalized
            print("Status: \(httpResponse.statusCode) - \(localisedStatus)")
        }

        if logStyleResponseHeader == .withResponseHeader {
            if let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: AnyObject] {
                self.logHeaders(headers)
            }
        }

        //            if let startDate = Timberjack.property(forKey: TimberjackRequestTimeKey, in: newRequest! as URLRequest) as? Date {
        //                let difference = fabs(startDate.timeIntervalSinceNow)
        //                print("Duration: \(difference)s")
        //            }

        if logStyleResponseData == .withResponseData {
            guard let data = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let pretty = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

                if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
                    print("JSON: \(string)")
                }
            }

            catch {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    print("Data: \(string)")
                }
            }
        }
    }

    static func logHeaders(_ headers: [String: AnyObject]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key) : \(value)")
        }
        print("]")
    }

    static func logHttpBody(_ data: Data?) {
        guard let data = data else { return }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let pretty = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

            if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
                print("Body: \(string)")
            }
        }

        catch {
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                print("Body: \(string)")
            }
        }
    }

}
