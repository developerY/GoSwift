//
//  HealthUIView.swift
//  GoSwift
//
//  Created by Siamak Ashrafi on 7/24/22.
//

import SwiftUI

struct HealthView: View {
    @ObservedObject var healthVM: HealthViewModel
    
    
    var body: some View {
        Text("Health View")
    }
}

struct HealthUIView_Previews: PreviewProvider {
    
    static var healthVM = HealthViewModel(
        getAllHealtInfo: Resolver.shared.resolve(GetHealthInfoUseCaseProtocol.self)
    )
    static var previews: some View {
        HealthView(healthVM: healthVM)
    }
}
