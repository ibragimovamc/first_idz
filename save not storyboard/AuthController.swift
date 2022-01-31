//
//  AuthController.swift
//  first_idz
//
//  Created by Ибрагимова Татьяна on 25.01.2022.
//
import Foundation

class Auth{
    static let baseUrl = "https://fefu.t.feip.co/api"
    static private let regLink = "https://fefu.t.feip.co/api/auth/register"
    static private let logLink = "https://fefu.t.feip.co/api/auth/login"
    
    static let decoder: JSONDecoder = ({
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom { decoder in

            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            let dateFormatter = ISO8601DateFormatter()
            guard let date = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container,
                    debugDescription: "Cannot decode date string \(dateString)")
            }
            
            return date
        }

        return decoder
    })()
    static let encoder: JSONEncoder = ({
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)

        return encoder
    })()
    
    init() {
        Auth.decoder.keyDecodingStrategy = .convertFromSnakeCase
        Auth.encoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    static func register(_ body: Data, User: @escaping ((UserModelToken) -> Void), errors: @escaping ((ErrorModel) -> Void)){
        guard let url = URL(string: regLink) else {
            print("URL error")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                
                case 422:
                    do {
                        let errorData = try Auth.decoder.decode(ErrorModel.self, from: data)
                        errors(errorData)
                        return
                    } catch let err {
                        print("Error #422 \(err)")
                    }
                case 200:
                    do {
                        let userData = try Auth.decoder.decode(UserModelToken.self, from: data)
                        User(userData)
                        return
                    } catch let err {
                        print("Error: Decode failed \(err)")
                    }
                default:
                    return
                }
            }
        }
        task.resume()
        }
    
    static func logout(resolve: @escaping(() -> Void),
                       reject: @escaping((ErrorModel) -> Void)) {

        guard let url = URL(string: baseUrl + "/auth/logout") else {
            return
        }

        let request = postRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }

            guard let res = response as? HTTPURLResponse else {
                return
            }

            switch res.statusCode {
            case 200:
                resolve()

            case 401:
                do {
                    let error = try decoder.decode(ErrorModel.self, from: data)
                    reject(error)
                } catch {
                    print("Decode error: \(error)")
                }

            default:
                break
            }
        }
        task.resume()
    }
    
    static func login(_ body: Data, User: @escaping ((UserModelToken) -> Void), errors: @escaping ((ErrorModel) -> Void)){
        guard let url = URL(string: logLink) else {
            print("URL error")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                
                case 422:
                    do {
                        let errorData = try Auth.decoder.decode(ErrorModel.self, from: data)
                        errors(errorData)
                        return
                    } catch let err {
                        print("Error #422 \(err)")
                    }
                case 200:
                    do {
                        let userData = try Auth.decoder.decode(UserModelToken.self, from: data)
                        User(userData)
                        return
                    } catch let err {
                        print("Error: Decode failed \(err)")
                    }
                default:
                    return
                }
            }
        }
        task.resume()
        }
    
    static func createRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)

        if let token = UserDefaults.standard.string(forKey: "token") {
            request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
    
    static func getRequest(url: URL, data: Data? = nil) -> URLRequest {
        var request = self.createRequest(url)

        request.httpMethod = "GET"
        request.httpBody = data

        return request
    }
    static func postRequest(url: URL, data: Data? = nil) -> URLRequest {
        var request = self.createRequest(url)

        request.httpMethod = "POST"
        request.httpBody = data

        return request
    }
}

extension Auth {
    static func profile(resolve: @escaping((UserModel) -> Void),
                        reject: @escaping((ErrorModel) -> Void)) {

        guard let url = URL(string: baseUrl + "/user/profile") else {
            return
        }

        let request = getRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            guard let res = response as? HTTPURLResponse else {
                return
            }

            switch res.statusCode {
            case 200:
                do {
                    let user = try decoder.decode(UserModel.self, from: data)
                    resolve(user)
                } catch let e {
                    print("Decode error: \(e)")
                }

            case 401:
                do {
                    let error = try decoder.decode(ErrorModel.self, from: data)
                    reject(error)
                } catch {
                    print("Decode error: \(error)")
                }

            default:
                break
            }
        }
        task.resume()
    }
    
}
