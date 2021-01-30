//
//  Service.swift
//  Todo App
//
//  Created by Blankz on 30/1/2564 BE.
//

import Foundation
import Alamofire

enum ServiceResponse {
    case success(Data)
    case failure(String)
}

class Service {
    static let shared = Service()
    
    private var alamoFire: Session!
    private let baseUrl = "https://api-nodejs-todolist.herokuapp.com"
    
    enum ApiUrl {
        case register
        case login
        case logout
        case task(String?)
        
        var path: String {
            switch self {
            case .register:
                return "/user/register"
            case .login:
                return "/user/login"
            case .logout:
                return "/user/logout"
            case .task(.none):
                return "/task"
            case .task(.some(let id)):
                return "/task/\(id)"
            }
        }
    }
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        #if DEBUG
        alamoFire = Session(configuration: configuration,
                            eventMonitors: [AlamofireLogger()])
        #else
        alamoFire = Session(configuration: configuration)
        #endif
    }
    
    private func getHeader() -> HTTPHeaders {
        var header: [HTTPHeader] = [.accept("application/json")]

        if let token = KeychainAccess.shared.token {
            header.append(.authorization(bearerToken: token))
        }
        
        return HTTPHeaders(header)
    }
    
    @discardableResult
    func requestData(httpMethod: HTTPMethod = .get,
                     link: ApiUrl,
                     parameter: Parameters? = nil,
                     completionHandler: @escaping (ServiceResponse) -> Void) -> DataRequest? {

        let request = alamoFire.request("\(baseUrl)\(link.path)",
                                        method: httpMethod,
                                        parameters: parameter,
                                        encoding: JSONEncoding.default,
                                        headers: getHeader())
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure:
                    if let string = NSString(data: response.data ?? Data(),
                                             encoding: String.Encoding.utf8.rawValue) {
                        completionHandler(.failure(string as String))
                    } else {
                        completionHandler(.failure(""))
                    }
                }
            }
        return request
    }
}

final class AlamofireLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        print(request.cURLDescription())
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        guard let item = request.response,
            let task = request.task,
            let httpMethod = task.originalRequest?.httpMethod,
            let time = request.metrics?.taskInterval.duration,
            let url = request.convertible.urlRequest else {
            return
        }
        
        if let error = task.error {
            print("[Error] \(httpMethod) '\(url)' [\(String(format: "%.04f", time)) s]:")
            print(error)
        } else {
            print("---------------------")
            print("\(item.statusCode) '\(url)' [\(String(format: "%.04f", time)) s]:")
            
            print("Headers: [")
            for (key, value) in item.allHeaderFields {
                print("  \(key): \(value)")
            }
            print("]")
            
            guard let data = request.data else { return }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                
                if let prettyString = String(data: prettyData, encoding: .utf8) {
                    print(prettyString)
                }
            } catch {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    print(string)
                }
            }
        }
    }
}
