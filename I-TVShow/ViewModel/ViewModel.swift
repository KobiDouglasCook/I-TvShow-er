//
//  ViewModel.swift
//  I-TVShow
//
//  Created by Fuego on 8/29/20.
//  Copyright © 2020 Kobi Cook. All rights reserved.
//

import Foundation


protocol ShowDelegate: class {
    func update()
}

class ViewModel {
    
    weak var delegate: ShowDelegate?
    
    var show: Show! {
        didSet {
            delegate?.update()
        }
    }
    
}

extension ViewModel {
    
    func getShow(called query: String) {
        sharedTvService.get(query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let show):
                self.show = show
                print("received show: \(show.name)")
            case .failure(let error):
                self.show = nil
                print("error retrieving shows: \(error.localizedDescription)")
            }
        }
    }
}
