//
//  CourseListInteractor.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 03.08.2024.
//

import Foundation

protocol CourseListInteractorInputProtocol {
    init(presenter: CourseListInteractorOutputProtocol)
    func fetchCourses()
}

protocol CourseListInteractorOutputProtocol: AnyObject {
    func coursesDidReceive(with dataStore: CourseListDataStore)
}

class CourseListInteractor: CourseListInteractorInputProtocol {
    private unowned let presenter: CourseListInteractorOutputProtocol
    
    required init(presenter: CourseListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchCourses() {
        NetworkManager.shared.fetchData { [unowned self] courses in
            let dataStore = CourseListDataStore(courses: courses)
            presenter.coursesDidReceive(with: dataStore)
        }
    }
}
