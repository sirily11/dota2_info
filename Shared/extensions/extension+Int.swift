//
//  extension+Int.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import Foundation
extension Int{
    func secondsToHoursMinutesSeconds() -> (Int, Int, Int) {
        
      return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }

}
