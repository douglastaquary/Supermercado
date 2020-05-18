//
//   NearestMarketView.swift
//  Supermercado
//
//  Created by Douglas Taquary on 15/04/20.
//  Copyright © 2020 Douglas Taquary. All rights reserved.
//

import SwiftUI
import MapKit

struct NearestMarketView: View {

    @State var locationManager = CLLocationManager()
    @State var showMapAlert = false
    
    @ObservedObject var viewModel: NearestMarketViewModel = NearestMarketViewModel()
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                Text("Locais próximos a você")
                    .font(.caption)
                    .foregroundColor(Color.secondary)
                    .padding(.leading)
                
                MapView(
                    locationManager: $locationManager,
                    showMapAlert: $showMapAlert
                )
                .alert(isPresented: $showMapAlert) {
                    Alert(
                        title: Text("Acesso à localização negado"),
                        message: Text("Sua localização é necessária."),
                        primaryButton: .cancel(),
                        secondaryButton: .default(Text("Configurações"),
                                                
                        action: {
                            self.goToDeviceSettings()
                            
                        })
                    )
                }
            }
            .padding(.top, 24)
            .frame(height: 256)
            
            VStack(alignment: .leading) {
                HStack() {
                    Image("icon_chevron")
                        .frame(width: 26, height: 24)
                }
                .frame(maxWidth: .infinity)
                
                if self.viewModel.loadingPlaces {
                    ActivityIndicatorView().animation(.spring())
                } else {
                    Text(self.viewModel.places.count > 1 ? "\(self.viewModel.places.count) lugares encontrados" : "\(self.viewModel.places.count) lugar encontrado")
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                        .padding(.bottom)
                    ForEach(0..<self.viewModel.places.count) { index in
                        MarketView(place: self.viewModel.places[index])
                    }
                }
            
            }
            .padding()
        }
        .foregroundColor(.systemBackground)
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .systemBackground
            self.viewModel.search(to: self.viewModel.location)
        }
        .navigationBarTitle(Text("Mercados próximos"), displayMode: .inline)
        .accentColor(.black)
        .navigationBarColor(.systemBackground)
    }

}

struct NearestMarketView_Previews: PreviewProvider {
    static var previews: some View {
        NearestMarketView()
    }
}


extension NearestMarketView {
  ///Path to device settings if location is disabled
  func goToDeviceSettings() {
    guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
