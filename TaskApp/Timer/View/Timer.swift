//
//  Home.swift
//  Timer
//
//  Created by junhyeok KANG on 2023/01/19.
//

import SwiftUI

struct Stimer: View {
    @EnvironmentObject var timerModel: TimerModel
    var body: some View {
        VStack{
            Text("Stopwatch")
                .font(.title.bold())
                .foregroundColor(.white)
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.blue)
                        .frame(width: 170)
                }
            
            GeometryReader{proxy in
                VStack(spacing: 10){
                    Text("목표시간")
                        .font(.title2.bold())
                        .foregroundColor(.indigo)
                        .padding(.top)
                    Text(timerModel.setTimeStringValue)
                        .font(.system(size: 35, weight: .semibold))
                        .rotationEffect(.init(degrees: 0))
                        .foregroundColor(.indigo)
                        .opacity(timerModel.progress <= 1 ? 0.5 : 1)
                        .animation(.none, value: timerModel.setTimeStringValue)
                    
                    ZStack{
                        Circle()
                            .fill(.white.opacity(0.03))
                            .padding(-40)
                        Circle()
                            .trim(from: 0, to:timerModel.progress)
                            .stroke(.indigo.opacity(0.05),lineWidth: 80)
                        
                        //그림자
                        Circle()
                            .stroke(Color(.systemBlue),lineWidth: 7)
                            .blur(radius: 15)
                        
                        Circle()
                            .fill(Color(.white))
                        
                        Circle()
                            .trim(from: 0, to: timerModel.progress)                            .stroke(LinearGradient(gradient: Gradient(colors: [.black, .purple,.indigo,.blue,.green]), startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.7),lineWidth: 10)
                        
                        // 동그라미
                        GeometryReader{proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color(.systemBlue))
                                .frame(width: 30, height: 30)
                                .overlay(content: {
                                    Circle()
                                        .fill(.white)
                                        .padding(5)
                                })
                                .frame(width: size.width,height: size.height,alignment: .center)
                                .offset(x:size.height / 2)
                                .rotationEffect(.init(degrees: timerModel.progress * 360))
                            
                        }
                        // 가운데 숫자 출력하기
                        Text(timerModel.timeStringValue)
                            .font(.system(size: 45, weight: .semibold))
                            .rotationEffect(.init(degrees: 90))
                            .opacity(0.7)
                            .animation(.none, value: timerModel.progress)
                        
                    }
                    .padding(40)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: timerModel.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    //MARK: study time reset
                    Button{
                        if !timerModel.isStarted{
                            timerModel.resetTimer()
                        }
                        
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath" )
                            .font(.largeTitle.bold())
                            //.foregroundColor(.black)
                    }
                    .opacity(timerModel.totalSec == 0 ? 0 : 1)
                    
                    ZStack{
                        //MARK: time setting
                        Button{
                            if !timerModel.isStarted{
                                if timerModel.totalSec == 0 {
                                    timerModel.addNewTimer = true
                                }
                            }
                            //totalSec가 0 일 때만, 데이터 생성
                            
                        } label: {
                            Image(systemName: "timer" )
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                                .frame(width: 90, height: 90)
                                .background{
                                    Circle()
                                        .fill(.blue)
                                }
                                .shadow(color: Color(.systemBlue), radius: 8,x: 0, y: 0)
                        }
                        //MARK: stop and restart
                        Button{
                            if timerModel.isStarted{
                                //시간 정지 및 현재 시간 업데이트
                                timerModel.stopTimer()
                            }else{
                                timerModel.startTimer()
                            }
                            
                            
                        } label: {
                            Image(systemName: timerModel.isStarted ? "pause" : "play")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                                .frame(width: 90, height: 90)
                                .background{
                                    Circle()
                                        .fill(.blue)
                                }
                                .shadow(color: Color(.systemBlue), radius: 8,x: 0, y: 0)
                        }
                        .opacity(timerModel.totalSec == 0 ? 0 : 1)
                        

                       
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
                }
            }
        }
        .padding()
        .background{
            Color(.white)
                .ignoresSafeArea()
        }
        .overlay(content: {
            ZStack{
                Color.black
                    .opacity(timerModel.addNewTimer ? 0.25 : 0)
                    .onTapGesture {
                        timerModel.hour = 0
                        timerModel.min = 0
                        timerModel.sec = 0
                        timerModel.addNewTimer = false
                    }
                
                NewTimerView()
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .offset(y:timerModel.addNewTimer ? 0 : 400)
                }
                .animation(.easeInOut, value: timerModel.addNewTimer)
            })
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) {_ in
                if timerModel.isStarted{
                    timerModel.updatingTimer()
            }
            
        }
        
    }
    
    //MARK: NEW Timer Bottom sheet
    @ViewBuilder
    func NewTimerView()-> some View{
        VStack(spacing: 15){
            Text("Setting")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.top,10)
            
            HStack(spacing: 15){
                Text("\(timerModel.setHour) hr")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical,12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.1))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 12, hint: "hr"){ value in
                            timerModel.setHour  = value
                        }
                    }
                
                Text("\(timerModel.setMin) min")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical,12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.1))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 60, hint: "min"){ value in
                            timerModel.setMin = value
                        }
                    }
                
                
                Text("\(timerModel.setSec) sec")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                    .padding(.vertical,12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.1))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 60, hint: "sec"){ value in
                            timerModel.setSec  = value
                        }
                    }
            }
            .padding(.top,20)
            
            Button{
                //MARK: 데이터 저장하기
                //목표시간 저장하기
                timerModel.startTimer()
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.systemBlue))
                    .padding(.vertical)
                    .padding(.horizontal,100)
                    .background{
                        Capsule()
                            .fill(Color(.white))
                    }
            }
            .disabled(timerModel.setSec == 0)
            .opacity(timerModel.setSec == 0 ? 0.5 : 1 )
            .padding(.top)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(.systemBlue))
                .ignoresSafeArea()
        }
    }
    
    
    // MARK: Reuseable context menu options
    @ViewBuilder
    func ContextMenuOptions(maxValue: Int, hint: String, onClick: @escaping (Int)->())->some View{
        ForEach(0...maxValue,id: \.self){ value in
            Button("\(value) \(hint)"){
                onClick(value)
            }
        }
    }
}


