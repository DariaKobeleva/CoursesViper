//
//  CourseDetailsIConfigurator.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 02.08.2024.
//

import Foundation

protocol CourseDetailsConfiguratorInputProtocol {
    func configure(with view: CourseDetailsViewController, and course: Course)
}

class CourseDetailsIConfigurator: CourseDetailsConfiguratorInputProtocol {
    func configure(with view: CourseDetailsViewController, and course: Course) {
        let presenter = CourseDetailsPresenter(view: view)
        let interactor = CourseDetailsInteractor(presenter: presenter, course: course)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
