//
//  extension+Int.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import Foundation
extension Int{
    func secondsToHoursMinutesSeconds() -> (String, String, String) {
        let hr =  self / 3600
        let min = (self % 3600) / 60
        let sec = (self % 3600) % 60
        
        var hrs = String(format: "%02d", abs(hr))
        let mins = String(format: "%02d", abs(min))
        let secs =  String(format: "%02d",  abs(sec))
        
        
        if hr < 0 || min < 0 || sec < 0{
            hrs = "-\(hrs)"
        }
        
      return (hrs,mins,secs)
    }

}
