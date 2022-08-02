//
//  CalendarUIView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/10/22.
//

import SwiftUI
import EventKit
import MapKit

struct CalendarUIView: View {
    @ObservedObject var calVM: CalendarViewModel
    @State private var dates: Set<DateComponents> = []
    
    @State var  myEvent: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
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
                    HStack {
                        GeoEventMapView(event: event)
                        NavigationLink("\(event.title)\n\n\(event.startDate.formatted())", value: event)
                    }.frame(height:100)
                }.navigationDestination(for: EKEvent.self){ event in
                    DetailedCalendarUIView(calVM: calVM, path: $calPath, event: event )
                } // NEW iOS 16
                
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
    
    
    static var transVM = TransitMapViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self),
        getAllBartStations: Resolver.shared.resolve(GetAllBartStationsUseCaseProtocol.self),
        getAllWalkingRoutes: Resolver.shared.resolve(GetAllWalkingRoutesUseCaseProtocol.self),
        getCurrentCalEvent : Resolver.shared.resolve(GetCurrentCalEventUseCaseProtocol.self)
    )
    
    static var calVM = CalendarViewModel(
        getCurrentCalEvent: Resolver.shared.resolve(GetCurrentCalEventUseCaseProtocol.self),
        getCalEvents: Resolver.shared.resolve(CalEventsUseCaseProtocol.self)
    )
    
    
    static var previews: some View {
        CalendarUIView(calVM: calVM)
    }
}
