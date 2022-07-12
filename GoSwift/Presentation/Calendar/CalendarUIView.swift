//
//  CalendarUIView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/10/22.
//

import SwiftUI

struct CalendarUIView: View {
    @ObservedObject var viewModel: CalendarViewModel
    @State private var date = Date()
    // @State private var dates: Set<DateComponents> = []
    
    
        var body: some View {
            if #available(iOS 13, *) { // for fun try iOS 17
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.graphical)
            } else {
                VStack {
                    Text("Why are you running such an old OS!")
                    Text("UPDATE NOW!")
                }
            }
        }
    }


struct CalendarUIView_Previews: PreviewProvider {
    static var vm = CalendarViewModel()
    
    static var previews: some View {
        CalendarUIView(viewModel: vm)
    }
}
