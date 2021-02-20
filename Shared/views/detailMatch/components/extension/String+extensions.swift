//
//  String+extensions.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import Foundation

extension String{
    func getAssetURL() -> String{
        var url = "https://sirily11.github.io/dota2_patch_fetcher/assets/" + self.components(separatedBy: "images/")[1]
        url = url.replacingOccurrences(of: "png?", with: "png")
        url = url.components(separatedBy: "t=")[0]
        
        return url
    }
}
