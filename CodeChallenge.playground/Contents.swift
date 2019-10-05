import Foundation

protocol httpBodyRepresentable {
    func makeRestfulBody(builder: RestfulReqestBuilder) throws -> Data
    func makeGraphQLBody(builder: GraphQLRequestBuilder) throws -> Data
}

extension httpBodyRepresentable where Self: Encodable {
    func makeRestfulBody(builder: RestfulReqestBuilder) throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func makeGraphQLBody(builder: GraphQLRequestBuilder) throws -> Data {
        // make mutations data
    }
}

struct RPComment: Encodable, httpBodyRepresentable {}
struct RPAnnotation: Encodable, httpBodyRepresentable {}

protocol RequestBuilder {
    func makeURL() -> URL
    func makeHeaders() -> [String: String]?
    func build(with data: httpBodyRepresentable) throws -> URLRequest
}

extension RequestBuilder {
    func makeURL() -> URL {
        assertionFailure("Override required")
        return URL(string: "")!
    }
    
    func makeHeaders() -> [String: String]? {
        return nil
    }
}

class RestfulReqestBuilder: RequestBuilder {
    func build(with data: httpBodyRepresentable) throws -> URLRequest {
        var req = URLRequest(url: makeURL())
        req.allHTTPHeaderFields = makeHeaders()
        req.httpBody = try data.makeRestfulBody(builder: self)
        return req
    }
}

class GraphQLRequestBuilder: RequestBuilder {
    func build(with data: httpBodyRepresentable) throws -> URLRequest {
        var req = URLRequest(url: makeURL())
        req.allHTTPHeaderFields = makeHeaders()
        req.httpBody = try data.makeGraphQLBody(builder: self)
        return req
    }
}
