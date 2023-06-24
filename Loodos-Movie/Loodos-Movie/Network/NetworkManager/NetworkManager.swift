//
//  NetworkManager.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 21.06.2023.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    static let shared: NetworkManagerProtocol = NetworkManager()
    
    func sendRequest<T>(request: NetworkRequest, completionHandler: @escaping ((NetworkResult<T?,NetworkErrorModel>) -> Void)) where T : Decodable {
        
        do {
            let urlRequest = try makeRequest(request: request)
            
            log(request: urlRequest)
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                self.log(response: response, data: data, error: error)
                // Check error
                if let error = error {
                    return completionHandler(.failure(.init(with: .bussinessError, message: error.localizedDescription)))
                }
                // Check Response
                guard
                    self.isResponseOK(response)
                else {
                    return completionHandler(.failure(.init(with: .failedResponse, message: "Backend did not return a positive response.".localized)))
                }
                // Parse Model
                if let data = data, let response = try? JSONDecoder().decode(T.self, from: data){
                    return completionHandler(.success(response))
                }
                return completionHandler(.failure(.init(with: .parseError, message: "Response model could not be parsed".localized)))
            }
            .resume()
            
        } catch {
            if let myError = error as? NetworkError {
                return completionHandler(.failure(.init(with: myError, message: myError.localizedDescription)))
            }
            return completionHandler(.failure(.init(with: .bussinessError, message: error.localizedDescription)))
        }
    }
    
    private func makeRequest(request: NetworkRequest) throws -> URLRequest {
        
        guard
            let url = URL(string: request.serviceConfig.url),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else{
            throw NetworkError.invalidURL
        }
        
        // configure url parameters
        if let urlParams = request.urlParams, !urlParams.isEmpty {
            var items: [URLQueryItem] = []
            urlParams.forEach { param in
                items.append(URLQueryItem(name: param.key, value: param.value))
            }
            components.queryItems = items
        }
        
        var urlRequest = URLRequest(
            url: components.url!,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: request.timeOut
        )
        
        urlRequest.httpMethod = request.serviceConfig.httpMethod.rawValue
        
        return urlRequest
    }
    
    private func isResponseOK(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        let statusCode = urlResponse.statusCode
        let isResultPossitive = statusCode >= 200 && statusCode < 300
        return isResultPossitive
    }
}

extension NetworkManager {
    func log(request: URLRequest) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var output = """
       \(urlAsString) \n\n
       \(method) \(path)?\(query) HTTP/1.1 \n
       HOST: \(host)\n
       """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            output += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        print(output)
    }
    
    func log(response: URLResponse?, data: Data?, error: Error?) {
        print("\n - - - - - - - - - - INCOMMING - - - - - - - - - - \n")
        
        guard var response = response as? HTTPURLResponse else{
            print("Response couldnt convert to HTTPURLResponse")
            return
        }
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlString = response.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        var output = ""
        if let urlString = urlString {
            output += "\(urlString)"
            output += "\n\n"
        }
        output += "HTTP \(response.statusCode) \(path)?\(query)\n"
        if let host = components?.host {
            output += "Host: \(host)\n"
        }
        for (key, value) in response.allHeaderFields {
            output += "\(key): \(value)\n"
        }
        if let body = data {
            output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        if error != nil {
            output += "\nError: \(error!.localizedDescription)\n"
        }
        print(output)
    }
}
