//
//  CharacterListViewViewModel.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//

import Foundation
import Alamofire

final class CharacterListViewViewModel {
    
    var rmCharacter: RMCharacter?
    var modelClosure: ((_ event: Event) -> Void)?
    
    public func fetchAllCharacter() {
        
        AF.request(CustomURLRequest.character,
                   method: .get,
                   parameters: nil,
                   headers: ["Content-Type": "application/json"])
            .validate() // Ensure a 200-299 status code
            .responseDecodable(of: RMCharacter.self) {  [weak self] response in
                guard let storngSelf = self else { return }
                switch response.result {
                case .success(let model):
                    // Handle the successful response
                    print("Character Info: \(model)")
                    if storngSelf.rmCharacter?.results == nil {
                        storngSelf.rmCharacter = model
                    } else {
                        storngSelf.rmCharacter?.results?.append(contentsOf: model.results ?? [])
                        storngSelf.rmCharacter?.info = model.info
                    }
                    storngSelf.modelClosure?(.valid)
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                    storngSelf.modelClosure?(.error(error))
                }
            }
        
//        APIClient.shared.executeRequest(.character,
//                                        method: .get,
//                                        expecting: RMCharacter.self) { [weak self] result  in
//            guard let storngSelf = self else { return }
//            switch result {
//            case .success(let model):
//                if storngSelf.rmCharacter?.results == nil {
//                    storngSelf.rmCharacter = model
//                } else {
//                    storngSelf.rmCharacter?.results?.append(contentsOf: model.results ?? [])
//                    storngSelf.rmCharacter?.info = model.info
//                }
//                storngSelf.modelClosure?(.valid)
//            case .failure(let error):
//                storngSelf.modelClosure?(.error(error))
//            }
//        }
    }
}

public enum Event {
    case valid
    case error(Error?)
}
