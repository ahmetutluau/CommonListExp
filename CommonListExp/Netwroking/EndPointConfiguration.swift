//
//  EndPointConfiguration.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 29.03.2024.
//

import Foundation

typealias QueryStringParameters = [String: String]?
typealias MultipartFormData = [(name: String, filename: String, data: Data)]?

//All endpoint routers will confirm this protocol
protocol EndpointConfiguration {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: QueryStringParameters { get }
    var httpBody: Data? { get }
    var headers: [CustomHTTPHeader]? { get }
    var multipartFormData: MultipartFormData  { get }
}

extension EndpointConfiguration {
    func makeUrlRequest() -> URLRequest {
        guard var components = URLComponents(string: APIConstants.baseURL + path) else { fatalError("Invalid base URL") }
        
        //Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        //Add queryParams
        if let queryParams = queryParameters {
            // For GET requests, append query parameters to the URL

            if method == .GET {
                var queryItems: [URLQueryItem] = []
                for (key, value) in queryParams {
                    let queryItem = URLQueryItem(name: key, value: String(describing: value))
                    queryItems.append(queryItem)
                }
                components.queryItems = queryItems
                request.url = components.url
                
            } else {
                // For other methods, add query parameters to the request body
                do {
                    let data = try JSONSerialization.data(withJSONObject: queryParams)
                    request.httpBody = data
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        //Add header
        headers?.forEach({ header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        })
        
        //Add multipart form data
        if let multipartFormData = multipartFormData {
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            for formData in multipartFormData {
                request.httpBody?.append("--\(boundary)\r\n".data(using: .utf8)!)
                request.httpBody?.append("Content-Disposition: form-data; name=\"\(formData.name)\"; filename=\"\(formData.filename)\"\r\n".data(using: .utf8)!)
                request.httpBody?.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                request.httpBody?.append(formData.data)
                request.httpBody?.append("\r\n".data(using: .utf8)!)
            }
        }
        
        return request
    }
}
