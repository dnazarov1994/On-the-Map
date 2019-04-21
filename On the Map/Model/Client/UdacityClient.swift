//
//  File.swift
//  On the Map
//
//  Created by Dzhavid Babakishiiev on 3/17/19.
//  Copyright © 2019 Dzhavid. All rights reserved.
//

import Foundation
class UdacityClient  {
    
    static var loginData: LoginResponse?
    
    enum Endpoints {
        static let parseBase = "https://parse.udacity.com/parse/classes/"
        static let udacityBase = "https://onthemap-api.udacity.com/v1/"
    
        case studentLocations
        case login
        case userInfo
        case postLocation
        case logout
        
        var stringValue: String {
            switch self {
            case .login:
                return Endpoints.udacityBase + "session"
            case .studentLocations:
                return Endpoints.parseBase + "StudentLocation?limit=100"
            case .userInfo:
                return Endpoints.udacityBase + "users/" + UdacityClient.loginData!.account.key
            case .postLocation:
                return Endpoints.parseBase + "StudentLocation"
            case .logout:
                return Endpoints.udacityBase + "session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGetRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping ((ResponseType?,Error?)->Void) ) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let data = UdacityClient.removePrefixIsNeeded(data: data)
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let data = UdacityClient.removePrefixIsNeeded(data: data)
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }  catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        
    }
    
    class func taskForPutRequest<ResponseType: Decodable, RequestType: Encodable>(url: URL,
                                                          responseType: ResponseType.Type,
                                                          completion: @escaping ((ResponseType?,Error?)->Void),
                                                          body: RequestType) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let data = removePrefixIsNeeded(data: data)
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
        
        }
        task.resume()
    }
    
    class func taskForDeleteRequest<ResponseType: Decodable>(url:URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?,Error?)->Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let data = removePrefixIsNeeded(data: data)
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }
            
        }
        task.resume()
    }
    
    class func removePrefixIsNeeded(data: Data) -> Data {
        var responseJSON = String(data: data, encoding: .utf8)!
        guard responseJSON.contains(")]}") else { return data }
        let startIndex = responseJSON.startIndex
        let range = startIndex...responseJSON.index(startIndex, offsetBy: 4)
        responseJSON.removeSubrange(range)
        let data = responseJSON.data(using: .utf8)!
        return data
    }
}


    

