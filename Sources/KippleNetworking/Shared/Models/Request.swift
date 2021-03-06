// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public protocol Request {
    var baseURL: String? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    var encoding: ParameterEncoding { get }
    var rootResponseKey: String? { get }
}

public extension Request {
    var baseURL: String? {
        nil
    }

    var method: HTTPMethod {
        .get
    }

    var parameters: [String: Any] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }

    var encoding: ParameterEncoding {
        .defaultEncoding(for: self.method)
    }

    var rootResponseKey: String? {
        nil
    }
}

// MARK: - Supporting Types

public struct HTTPRequest: Request {
    public let baseURL: String?
    public let path: String
    public let method: HTTPMethod
    public let parameters: [String: Any]
    public let headers: [String: String]
    public let encoding: ParameterEncoding

    public init(
        path: String,
        baseURL: String? = nil,
        method: HTTPMethod = .get,
        parameters: [String: Any] = [:],
        headers: [String: String] = [:],
        encoding: ParameterEncoding? = nil
    ) {
        self.path = path
        self.baseURL = baseURL
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.encoding = encoding ?? .defaultEncoding(for: method)
    }
}

/// A convenience request that decodes the response of a GET request with no parameters or headers.
public struct DecodableRequest<T: Decodable>: Request, ResponseAnticipating {
    public typealias Response = T

    public let path: String

    public init(_ path: String, response: T.Type) {
        self.path = path
    }
}

public protocol ResponseAnticipating: Request {
    associatedtype Response: Decodable
}
