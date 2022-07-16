//
//  DetailedCalendarUIView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/15/22.
//

import SwiftUI
import EventKit


struct DetailedCalendarUIView: View {
    //@ObservedObject var calVM: CalendarViewModel
    let event: EKEvent
    
    var body: some View {
        
        HStack {
            //Circle().fill(event.color).frame(width: 10, height: 10, alignment: .center)
            
            
            VStack(alignment: .leading) {
                Text("Event Title \(event.title)")
                    .padding(.bottom, 2)
                Text("Event Time \(event.startDate)")
                    .font(.headline)
                //Text("Current Event \(calVM.currentCalEvent.eventName)")
            }
            
            Button("Set Event") {
                /*if let map_event = event.structuredLocation?.geoLocation?.coordinate {
                    myEvent.location  = CLLocation(latitude: map_event.latitude, longitude: map_event.longitude)
                }
                myEvent.eventName = event.title*/
            }
            
            Spacer()
        }.padding(.vertical, 5)
    }
    
}

















// Did not work
struct DetailedCalendarUIView_Previews: PreviewProvider {
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
                event.calendar = DetailedCalendarUIView_Previews.eventStore.defaultCalendarForNewEvents
                do {
                    try DetailedCalendarUIView_Previews.eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                print("Saved Event")
            }
            else{
                
                print("failed to save event with error : \(String(describing: error)) or access not granted")
            }
        }
    }
    
    static var previews: some View {
        //DetailedCalendarUIView(event: EKEvent(eventStore: eventStore))
        Text("ON HOLD")
    }
}
