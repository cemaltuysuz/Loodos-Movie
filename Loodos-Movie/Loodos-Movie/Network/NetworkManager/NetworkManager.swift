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
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
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
