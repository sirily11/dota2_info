//
//  extension+Int.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import Foundation
extension Int{
    func secondsToHoursMinutesSeconds() -> (String, String, String) {
      return (String(format: "%02d", self / 3600), String(format: "%02d", (self % 3600) / 60), String(format: "%02d",  (self % 3600) % 60))
    }

}
