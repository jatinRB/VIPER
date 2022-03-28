//
//  Interactor.swift
//  Project
//
//  Created by PC on 23/03/22.
//

import Foundation

enum FetchError: Error{
    case failed
}

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsersData()
}
class userInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsersData() {
        guard let url = URL(string: "https://reqres.in/api/users?page=1") else { return }
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                print(String(describing: error))
                return
            }
            do {
                let entities = try JSONDecoder().decode(UserData.self, from: data)
                self.presenter?.interactorDidFetchUsers(with: .success(entities.data))
            }
            catch{
                self.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
}
