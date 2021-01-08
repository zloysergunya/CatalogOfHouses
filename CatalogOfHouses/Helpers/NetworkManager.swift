//
//  HTTPRequest.swift
//
//  Created by Sergey Kotov on 26.09.2020.
//

import Foundation

var SERVER_URL: String {
    set { UserDefaults.standard.setValue(newValue, forKey: "URL") }
    get { return UserDefaults.standard.string(forKey: "URL") ?? "https://api.regenergy.ru/api2_test/mkdcatmob/"}
}

var AUTH_TOKEN: String? {
    set { if let v = newValue { UserDefaults.standard.setValue(v, forKey: "authToken") }
          else { UserDefaults.standard.removeObject(forKey: "authToken") }}
    get { return UserDefaults.standard.string(forKey: "authToken") }
}

func NetworkManager(_ url: String = SERVER_URL,
                 method: String = "POST",
                 params: [String:Any?] = [:],
                 constants: [String:Any?] = [:],
                 completion: @escaping (Data?, _ status: Int) -> Void) {
    var urn: String = ""
    var timeout = 15.0
    let body = NSMutableData()
    let values = params
    var contentType: String? = nil
    
    switch method {
    case "GET", "DELETE", "HEAD":
        if values.count > 0 {
            var toString: [String] = []
            values.forEach {
                if let v = $1 as? String {
                    toString.append("\($0)=\(v)")
                }
            }
            urn = "?" + toString.joined(separator: "&")
        }
    case "JSON":
        contentType = "application/json"
        if let json = params.jsonString() {
            body.appendString(json)
        }
    default:
        timeout = 30
        if values.count > 0 {
            let boundary = "iOS-\(UUID().uuidString)"
            contentType = "multipart/form-data; boundary=\(boundary)"
            for (key, value) in values {
                if let value = value {
                    body.appendString("--\(boundary)\r\nContent-Disposition: form-data; name=\"")
                    body.appendString("\(key)\"\r\n\r\n\(value)\r\n")
                }
            }
            body.appendString("--".appending(boundary.appending("--")))
        }
    }
    print("\nHTTPRequest[\(method)]:\n\(url)\(urn)")
    if let uri = URL(string: (url + urn).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) {
        let session = URLSession.shared
        var request = URLRequest(url: uri)
        request.httpMethod = method == "JSON" ? "POST" : method
        request.setValue(AUTH_TOKEN, forHTTPHeaderField: "X-Xsrf-Token")
        if let mime = contentType {
            print("\nЗАПРОС К СЕРВЕРУ\n\(String(data: body as Data, encoding: String.Encoding.utf8) ?? "П У С Т О")")
            request.setValue(mime, forHTTPHeaderField: "Content-Type")
            request.setValue("keep-alive", forHTTPHeaderField: "Connection")
            request.httpBody = body as Data
            request.timeoutInterval = timeout
        }

        let load = session.dataTask(with: request, completionHandler: { data, response, error in
            let status = response?.getStatus ?? 1000
            if let response = response as? HTTPURLResponse,
               let token = response.value(forHTTPHeaderField: "X-XSRF-TOKEN") {
                AUTH_TOKEN = token
            }
            print("\nОТВЕТ СЕРВЕРА СО СТАТУСОМ: \(status)\n\(String(data: data ?? Data(), encoding: String.Encoding.utf8) ?? "ПУСТОЕ")\n")
            
            DispatchQueue.main.async{() -> Void in
                completion(data, status)
            }
        })
        load.resume()
    }
}

extension Dictionary {
    func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

extension URLResponse {
    var getStatus: Int? {
        get {
            if let httpResponse = self as? HTTPURLResponse {
                return httpResponse.statusCode
            }
            return nil
        }
    }
}
