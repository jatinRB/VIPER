//
//  Presenter.swift
//  Project
//
//  Created by PC on 23/03/22.
//

import Foundation


protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            self.interactor?.getUsersData()
        }
    }
    var view: AnyView?
    
    
    func interactorDidFetchUsers (with result: Result<[User], Error>) {
        switch result {
        case .failure(let error):
            view?.update(with: "Something went wrong please try again")
            break
        case .success(let user):
            view?.update(with: user)
        }
    }
}
