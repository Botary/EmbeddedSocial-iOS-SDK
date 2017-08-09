//
// DeleteTopicNameRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Request to delete a topic name */
open class DeleteTopicNameRequest: JSONEncodable {

    public enum PublisherType: String { 
        case user = "User"
        case app = "App"
    }
    /** Gets or sets publisher type */
    public var publisherType: PublisherType?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["publisherType"] = self.publisherType?.rawValue

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}