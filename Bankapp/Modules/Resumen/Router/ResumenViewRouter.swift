//
//  ResumenViewRouter.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//

import Foundation

final class ResumenViewRouter: ResumenViewRouterProtocol {
    let view: ResumenView
    let presenter: ResumenViewPresenter
    let interactor: ResumenViewInteractor
    init() {
        self.view = ResumenView()
        self.interactor = ResumenViewInteractor(http: URLSessionClient())
        self.presenter = ResumenViewPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        presenter.interacator = interactor
        interactor.presenter = presenter
    }
}
