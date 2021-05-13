//
//  AnalyticsViewModel.swift
//  Gas
//
//  Created by Strong on 5/10/21.
//

import Foundation

class AnalyticsViewModel: AnalyticsViewOutput {
    
    weak var view: AnalyticsViewInput?
    var output: AnalyticsModuleOutput?
    
    private let dataProvider: UserServiceProtocol
    
    init(dataProvider: UserServiceProtocol) {
        self.dataProvider = dataProvider
    }
    
    func didLoad() {
        dataProvider.getAnalytics { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleData(data)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    private func handleData(_ data: AnalyticsDataModel) {
        let adapter = AnalyticsViewAdapter(median: data.median_usage.description)
        view?.display(adapter: adapter)
    }
    
}
