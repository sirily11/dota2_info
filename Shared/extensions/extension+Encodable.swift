//
//  extension+Encodable.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/26/21.
//

import Foundation

extension Encodable {
    
    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
}
