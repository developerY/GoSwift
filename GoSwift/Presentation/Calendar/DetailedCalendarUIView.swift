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
    @State var eventAddress = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0,
                                       longitude: 0.0),
        latitudinalMeters: 750,
        longitudinalMeters: 750)
    
    
    let event: EKEvent
    let geoCoder = CLGeocoder()
    
    
    private func region(event:EKEvent) -> MKCoordinateRegion? {
        guard let eventLoc = event.location else {
            return eventAddress
        }
        
        geoCoder.geocodeAddressString(eventLoc) { (placemarkes, error) in
            
            if error == nil {
                if let placemarker = placemarkes?[0]{
                    if let locPlace = placemarker.location {
                        eventAddress = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: locPlace.coordinate.latitude, longitude: locPlace.coordinate.longitude ),
                            latitudinalMeters: 750,
                            longitudinalMeters: 750
                        )
                        print("Event lat long \(String(describing: eventAddress))")
                    }
                    return
                }
            }
        }
        return eventAddress
    }

    
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
                }
                    
                //Text("Current Event \(calVM.currentCalEvent.eventName)")
            }
            
            Button("Set Event") {
                path.removeLast(1) // NOTE: new in iOS 16 programmatic navigation
                // Navigate back and pass event
                if let map_event = event.structuredLocation?.geoLocation?.coordinate {
                    calVM.setCurrentEvent(myEvent: event.title, eventLoc:CLLocation(latitude: map_event.latitude, longitude: map_event.longitude))
                }
            }.padding()
                .border(.gray)
            Spacer()
           
            if let myEvent = region(event: event) {
                Map(coordinateRegion: .constant(myEvent)).padding()//.frame(width: 400, height: 300).
            } else {
                Text("NO MAP")
            }
                
            Spacer()
        }.padding(.vertical, 5)
    }
    
}


struct DetailedCalendarUIView_Previews: PreviewProvider {
    
    static var calVM = CalendarViewModel(
        getCurrentCalEvent: Resolver.shared.resolve(GetCurrentCalEventUseCaseProtocol.self)
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
