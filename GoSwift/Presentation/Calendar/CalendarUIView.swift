//
//  CalendarUIView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/10/22.
//

import SwiftUI

struct CalendarUIView: View {
    @ObservedObject var calVM: CalendarViewModel
    @State private var date = Date()
    @State private var dates: Set<DateComponents> = []
    @EnvironmentObject var myEvent: MyEvent
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                /*
                 MultiDatePicker("Start Date",selection: $dates, displayedComponents: .hourAndMinute)
                 */
                    if calVM.events?.isEmpty ?? true {
                        Text("No Events")
                    }
                    List(calVM.events ?? [], id: \.self) { event in
                        NavigationLink {
                            DetailedCalendarUIView(event: event)
                            } label: {
                                VStack {
                                    Text("\(event.title) @ \(event.location ?? "No Location")")
                                }
                            }
                        
                    }
                
            }
        
            if #available(iOS 13, *) { // for fun try iOS 17
                DatePicker("Start Date",selection: $date)
                    .datePickerStyle(.graphical)
                
            } else {
                VStack {
                    Text("Why are you running such an old OS!")
                    Text("UPDATE NOW!")
                }
            }
        }
    }
}


struct CalendarUIView_Previews: PreviewProvider {
    static var vm = CalendarViewModel()
    // static var transVM = TransitMapViewModel()
    static var previews: some View {
        //CalendarUIView(calVM: vm, transVM: transVM)
        Text("HOLD")
    }
}
