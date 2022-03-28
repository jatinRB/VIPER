//
//  Router.swift
//  Project
//
//  Created by PC on 23/03/22.
//

import Foundation
import UIKit

typealias EntyPoint = AnyView & UIViewController

protocol AnyRouter {
    var enty: EntyPoint? { get }
    
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter{    
    var enty: EntyPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        //Assign VIP
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = userInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.enty = view as? EntyPoint
        
        return router
    }
}
