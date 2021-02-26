//
//  extension+String.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/26/21.
//

import Foundation

extension String{
    func dictionaryValue() -> [String: AnyObject]
    {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject]
                if let json = json{
                    return json
                } else{
                    return NSDictionary() as! [String : AnyObject]
                }
                
            } catch {
                print("Error converting to JSON")
            }
        }
        return NSDictionary() as! [String : AnyObject]
    }
    
}



extension String{
    func getAssetURL() -> String{
        var url = "https://sirily11.github.io/dota2_patch_fetcher/assets/" + self.components(separatedBy: "images/")[1]
        url = url.replacingOccurrences(of: "png?", with: "png")
        url = url.components(separatedBy: "t=")[0]
        
        return url
    }
}
