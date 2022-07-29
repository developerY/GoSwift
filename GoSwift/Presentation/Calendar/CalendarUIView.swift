//
//  CalendarUIView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/10/22.
//

import SwiftUI
import EventKit

struct CalendarUIView: View {
    @ObservedObject var calVM: CalendarViewModel
    @State private var date = Date()
    @State private var dates: Set<DateComponents> = []
    
    @State private var calPath = NavigationPath()// New in iOS 16

    
    
    var body: some View {
        NavigationStack(path: $calPath) {
            VStack {
            
        
                /*
                 MultiDatePicker("Start Date",selection: $dates, displayedComponents: .hourAndMinute)
                 */
                if calVM.events?.isEmpty ?? true {
                    Text("No Events")
                }
                
                List(calVM.events ?? [], id: \.self) { event in
                    NavigationLink("\(event.title) @ \(event.location ?? "No Location")", value: event)
                }.navigationDestination(for: EKEvent.self){ event in
                    DetailedCalendarUIView(calVM: calVM, path: $calPath,event: event )
                }
               
                //Text("Current event \(calVM.currentCalEvent.eventName)")
                
            }.onAppear {
                Task {
                    await calVM.getCalEvents()
                }
                //calVM.getCurrentEvent()
            }
            
            /*if #available(iOS 13, *) { // for fun try iOS 17
                DatePicker("Start Date",selection: $date)
                    .datePickerStyle(.graphical)
                
            } else {
                VStack {
                    Text("Why are you running such an old OS!")
                    Text("UPDATE NOW!")
                }
            }*/
        }
    }
}


struct CalendarUIView_Previews: PreviewProvider {
    //static var vm = CalendarViewModel()
    // static var transVM = TransitMapViewModel()
    static var previews: some View {
        //CalendarUIView(calVM: vm, transVM: transVM)
        Text("HOLD")
    }
}
