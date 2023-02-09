//
//  TimerModel.swift
//  TaskApp
//
//  Created by junhyeok KANG on 2023/02/02.
//

import SwiftUI

class TimerModel: NSObject, ObservableObject {
    @Published var progress: CGFloat = 0
    @Published var timeStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var min: Int = 0
    @Published var sec: Int = 0
    
    //목표시간 관련 변수
    @Published var setTimeStringValue: String = "00:00"
    @Published var setHour: Int = 0
    @Published var setMin: Int = 0
    @Published var setSec: Int = 0
    
   
   
    @Published var totalSec: Int = 0
    @Published var staticTotalSec: Int = 0
    
    
    //MARK: 타이머 시작
    func startTimer(){
        withAnimation(.easeInOut(duration: 0.25)){isStarted = true
            timeStringValue = "\(hour == 0 ? "" : "\(hour):")\(min >= 10 ? "\(min):":"0\(min):")\(sec >= 10 ? "\(sec)":"0\(sec)")"
            setTimeStringValue = "\(setHour == 0 ? "" : "\(setHour):")\(setMin >= 10 ? "\(setMin):":"0\(setMin):")\(setSec >= 10 ? "\(setSec)":"0\(setSec)")"
            
            totalSec = (hour * 3600) + (min * 60) + sec
            staticTotalSec = (setHour * 3600) + (setMin * 60) + setSec
            addNewTimer = false
            
        }
    }
    
    //MARK: 타이머 정지
    func stopTimer(){
        withAnimation{
            isStarted = false
        }
    }
    
    //MARK: 목표시간 재설정 및 정지
    func resetTimer(){
        withAnimation{
            isStarted = false
            totalSec = 0
            setTimeStringValue = "00:00"
            setHour = 0
            setMin = 0
            setSec = 0
        }
    }
    
    //MARK: 타이머 업데이트
        func updatingTimer(){
            totalSec += 1
            progress = CGFloat(totalSec) / CGFloat(staticTotalSec)
            progress = (progress < 0 ? 0 : progress)
            hour = totalSec / 3600
            min = (totalSec / 60 ) % 60
            sec = (totalSec % 60)
            timeStringValue = "\(hour == 0 ? "" : "\(hour):")\(min >= 10 ? "\(min):":"0\(min):")\(sec >= 10 ? "\(sec)":"0\(sec)")"
            
            if hour == 0 && sec == 0 && min == 0 {
                isStarted = false
                print("Finished")
            }
        }
    
            

}
