//
//  BikeListDetailView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/2/22.
//
//  build with https://kristaps.me/blog/swiftui-map-annotations/
import SwiftUI
import MapKit

private struct StationAnnotationItem : Identifiable {
    var stationName :String
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct PlaceAnnotationDetailView: View {
    @State private var showTitle = true
    @State private var iconType =  "bicycle.circle"
  
  let title: String
  
  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .font(.callout)
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
        .opacity(showTitle ? 0 : 1)
      
        Image(systemName:iconType)
        .font(.title)
        .foregroundColor(.blue).opacity(0.7)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.cyan).opacity(0.7)
        .offset(x: 0, y: -5)
    }
    .onTapGesture {
      withAnimation(.easeInOut) {
        showTitle.toggle()
      }
    }
  }
}


struct BikeListDetailMapView: View {
    var station:Station
    @State var lat:Double
    @State var lon:Double
    fileprivate var annotationItems: [StationAnnotationItem]
        
    @State private var showingCredits = false
    @State private var bikeNumPicker = 1

    @State private var date = Date()

    
    init(station:Station) {
        self.station = station
        _lat = State(initialValue: station.lat)
        _lon = State(initialValue: station.lon)
        
        // place pin on station
        annotationItems = [
            StationAnnotationItem(stationName: station.name, coordinate : CLLocationCoordinate2D(latitude: station.lat, longitude: station.lon))
        ]
    }
    
    
    var body: some View {
        VStack {
            MapView(lat: $lat, lon: $lon, annotationItems: annotationItems).ignoresSafeArea(edges: .top)//.frame(height:300)
            //CircleImage()
            
            Text("\(station.name)").font(.title)
            // TextField("Amount", value: $bikeNumPicker)
            Section {
                
                HStack {
                    Text("\(Image(systemName: "bicycle"))").bikeSignStyle(bikeColor: .mint)
                    
                    Section{
                        Picker("Bike Number", selection: $bikeNumPicker) {
                            ForEach(1...station.capacity,id :\.self) { bikeNum in
                                Text(" bike number \(bikeNum)").font(.title)
                            }
                        }
                        //.pickerStyle(.segmented)
                        //Slider(value: $value)
                    }
                }
            }
            
            if #available(iOS 13, *) { // for fun try iOS 17
                DatePicker("Date/Time",selection: $date)
                    .padding()
                    //.datePickerStyle(.graphical)
            } else {
                VStack {
                    Text("Why are you running such an old OS!")
                    Text("UPDATE NOW!")
                }
            }
            
            
            Button("Pay Here") {//"\(station.name)") {
                showingCredits.toggle()
            }
            .sheet(isPresented: $showingCredits) {
                getBikeFromStation(station: station)
                    .presentationDetents([.medium, .large])
            }
       }
    }
}

struct MapView: View {
    @Binding private var lat:Double
    @Binding private var lon:Double
    
    fileprivate var mapStationMarker: [StationAnnotationItem]
    
    private let initLatMeters:Double = 250
    private let initLonMeters: Double = 250
    
    @State private var span: MKCoordinateSpan?
    
    fileprivate init(lat:Binding<Double>, lon:Binding<Double>,
         annotationItems: [StationAnnotationItem]) {
        _lat = lat
        _lon = lon
        self.mapStationMarker = annotationItems
    }
    
    private var region: Binding<MKCoordinateRegion> {
        Binding {
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            if let span = span {
                return MKCoordinateRegion(center: center, span: span)
            }  else {
                return MKCoordinateRegion(center: center, latitudinalMeters: initLonMeters, longitudinalMeters: initLonMeters)
            }
            
        } set: { region in
            //lat = region.center.latitude
            //lon = region.center.longitude
            //span = region.span
        }
    }
    
    var body: some View {
        Map (coordinateRegion: region, annotationItems: mapStationMarker) { item in
            //MapMarker(coordinate: item.coordinate)
            MapAnnotation(coordinate: item.coordinate) {
                PlaceAnnotationDetailView(title: item.stationName)
            }
        }
    }
    
    
}

struct CreditCardInfo {
    let name: String
    let num: String

    static let example = CreditCardInfo(name: "Ash Biker", num: "555 555 555 555")
}

struct bikeSchedualPicker: View {
    @State private var bikeDate = Date.now
    
    var body: some View {
        //!!!: access stored value pass Binding (projectedValue) use "$"
        DatePicker("Bike Date", selection: $bikeDate)
    }
    
}

struct getBikeFromStation : View {
    let station:Station
    @State private var animiAmount = 1.0

    var body: some View {
        VStack {
            CreditCardView()
            Button("Pay") {
                animiAmount += 1
            }.padding(20)
                .background(.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
                .blur(radius: (animiAmount - 2 ) * 3)
                .animation(.default, value: animiAmount)
        }
        //BikeCreditCardView(card: CreditCardInfo(name: "Ash Biker", num: "555 555 555 555"))
    }
}

struct BikeCreditCardView: View {
    let card: CreditCardInfo
    @State private var animiAmount = 1.0


    var body: some View {
        Form { //!!! VStack not as good
            bikeSchedualPicker()
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.white)
                
                VStack {
                    Text(card.name)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    Text(card.num)
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .frame(width: 450, height: 250)
            
            Button("Pay") {
                animiAmount += 1
            }.padding(20)
                .background(.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
                .blur(radius: (animiAmount - 2 ) * 3)
                .animation(.default, value: animiAmount)
        }
       
    }
}





struct BikeSignStyle:ViewModifier {
    let bikeColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(bikeColor)
            .padding()
            .background(.cyan.opacity(0.3).gradient) // !!!: iOS 16 add gradient to any color
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func bikeSignStyle(bikeColor : Color) -> some View {
        modifier(BikeSignStyle(bikeColor: bikeColor))
    }
}

struct BikeListDetailView_Previews: PreviewProvider {
    
    // Typed Property
    static let  station : Station  = Station(regionID: nil, eightdHasKeyDispenser: false, stationType: GoSwift.StationType.classic, lon: -122.44419392209238, name: "Hearst Ave at Detroit St", hasKiosk: true, electricBikeSurchargeWaiver: false, rentalUris: GoSwift.RentalUris(android: "https://sfo.lft.to/lastmile_qr_scan", ios: "https://sfo.lft.to/lastmile_qr_scan"), capacity: 19, shortName: "SF-X16", rentalMethods: [GoSwift.RentalMethod.creditcard, GoSwift.RentalMethod.key], lat: 37.73075943972763, stationID: "578", eightdStationServices: [], externalID: "41b2200f-7915-410b-95c6-084bc4d3dee8", legacyID: "578")
    
    static var previews: some View {
        VStack {
            BikeListDetailMapView(station: station)
        }
    }
}
