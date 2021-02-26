//
//  extension+NSDict.swift
//  dota2_info
//
//  Created by 李其炜 on 2/26/21.
//

import Foundation

extension NSDictionary{
    func JsonString() -> String
    {
        do{
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String.init(data: jsonData, encoding: .utf8)!
        }
        catch
        {
            return "error converting"
        }
    }
}


