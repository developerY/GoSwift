//
//  BikeListView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/16/22.
//
// SwiftUI is a subscriber to a Combine publisher
import SwiftUI

struct BikeListView: View {

    // Get viewmodel from DI
    @StateObject var vm = SharedBikesListViewModel(
        getAllSharedBikes: Resolver.shared.resolve(GetAllSharedBikesUseCaseProtocol.self) //GetAllSharedBikesUseCaseProtocol
        //deleteContact: Resolver.shared.resolve(DeleteContactUseCaseProtocol.self)
    )

    var body: some View {
        VStack() {
            Text("Bike List")
            List {
                ForEach(vm.sharedBikes) { item in
                    Text(item.name)
                }
            }.onAppear() {
                vm.getSharedBikes()
            }
        }
    }
}

struct BikeListView_Previews: PreviewProvider {
    static var previews: some View {
        BikeListView()
    }
}
