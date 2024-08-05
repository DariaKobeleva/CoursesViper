//
//  CourseListConfigurator.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 03.08.2024.
//

protocol CourseListConfiguratorInputProtocol {
    func configure(withView view: CourseListViewController)
}

class CourseListConfigurator: CourseListConfiguratorInputProtocol {
    func configure(withView view: CourseListViewController) {
        let presenter = CourseListPresenter(view: view)
        let interactor = CourseListInteractor(presenter: presenter)
        let router = CourseListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
