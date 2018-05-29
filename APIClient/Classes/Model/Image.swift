//
//  Image.swift
//  APIClientTutorial
//
//  Created by Jean Raphael on 14/02/2018.
//  Copyright © 2018 Jean Raphael Bordet. All rights reserved.
//

import Foundation

/// Common object for images coming from the Marvel API
/// Shows how to fully conform to Decodable
public struct Image: Decodable {
    /// Server sends the remote URL splits in two: the path and the extension
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    /// The remote URL for this image
    public let url: URL
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        
        guard let url = URL(string: "\(path).\(fileExtension)") else { throw CommonError.decoding }
        
        self.url = url
    }
}
