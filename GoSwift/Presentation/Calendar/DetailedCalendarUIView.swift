//
//  DetailedCalendarUIView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/15/22.
//

import SwiftUI
import EventKit
import MapKit


struct DetailedCalendarUIView: View {
    @ObservedObject var calVM: CalendarViewModel
    @Binding var path: NavigationPath
    let event: EKEvent
    
    
    var body: some View {
        
        VStack {
            //Circle().fill(event.color).frame(width: 10, height: 10, alignment: .center)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(event.title)")
                        .font(.headline)
                        .padding(.bottom, 2)
                    Text("@")
                    Text("\(event.startDate.formatted())")
                        .font(.subheadline)
                }
                    
                //Text("Current Event \(calVM.currentCalEvent.eventName)")
            }
            Spacer()
            Button("Set Event") {
                path.removeLast(1) // NEW: new in iOS 16 programmatic navigation
                // Navigate back and pass event
                if let map_event = event.structuredLocation?.geoLocation?.coordinate {
                    calVM.setCurrentEvent(myEvent: event.title, eventLoc:CLLocation(latitude: map_event.latitude, longitude: map_event.longitude))
                }
            }.padding()
                .border(.gray)
            Spacer()
            GeoEventMapView(event: event)
            Spacer()
        }.padding(.vertical, 5)
    }
    
}


struct DetailedCalendarUIView_Previews: PreviewProvider {
    
    static var calVM = CalendarViewModel(
        getCurrentCalEvent: Resolver.shared.resolve(GetCurrentCalEventUseCaseProtocol.self),
        getCalEvents: Resolver.shared.resolve(CalEventsUseCaseProtocol.self)
    )
    
    
    static var eventStore : EKEventStore = EKEventStore()
          
    // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
    init() {
        DetailedCalendarUIView_Previews.eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(String(describing: error))")
                
                let event:EKEvent = EKEvent(eventStore: DetailedCalendarUIView_Previews.eventStore)
                
                event.title = "Test Title"
                event.startDate = Date()
                event.endDate = Date()
                event.notes = "This is a note"
            
            }
            else{
                
                print("failed to save event with error : \(String(describing: error)) or access not granted")
            }
        }
    }
    
    static var previews: some View {
        DetailedCalendarUIView(calVM: calVM,
                               path: .constant(NavigationPath()),
                               event: EKEvent(eventStore: eventStore))
    }
}
