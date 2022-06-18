//
//  SharedBikesListViewModel.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 6/17/22.
//
import Foundation

class SharedBikesListViewModel: ObservableObject{
    private let getAllSharedBikes: GetAllSharedBikesUseCaseProtocol
    
    init(
        getAllSharedBikes: GetAllSharedBikesUseCaseProtocol
    ){
        self.getAllSharedBikes = getAllSharedBikes
    }
    
    @Published var errorMessage = ""
    @Published var sharedBikes : [SharedBikesResponseModel] = []
    
    func getSharedBikes() async{
        let result = await self.getAllSharedBikes.execute()
        switch result{
        case .success(let sharedBikes):
            self.sharedBikes = sharedBikes
        case .failure(_):
            self.errorMessage = "Error Fetching Contacts"
            
        }
    }
    
}
