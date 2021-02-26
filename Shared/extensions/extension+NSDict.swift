//
//  extension+NSDict.swift
//  dota2_info
//
//  Created by 李其炜 on 2/26/21.
//

import Foundation

func toJSONString(dic: [String: Any]?) -> String?
{
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dic ?? [], options: .prettyPrinted)
        return String(decoding: jsonData, as: UTF8.self)
    } catch {
        print(error.localizedDescription)
        return nil
    }
}


