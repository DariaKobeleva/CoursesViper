//
//  CourseListPresenter.swift
//  CoursesViper
//
//  Created by Дарья Кобелева on 03.08.2024.
//

import Foundation

struct CourseListDataStore {
    let courses: [Course]
}

class CourseListPresenter: CourseListViewOutputProtocol {
    var interactor: CourseListInteractorInputProtocol!
    var router: CourseListRouterInputProtocol!
    
    private unowned let view: CourseListViewInputProtocol
    private var dataStore: CourseListDataStore?
    
    required init(view: CourseListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchCourses()
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let course = dataStore?.courses[indexPath.row] else { return }
        router.openCourseDetailsViewController(with: course)
    }
}

//MARK: - CourseListInteractorOutputProtocol
extension CourseListPresenter: CourseListInteractorOutputProtocol {
    func coursesDidReceive(with dataStore: CourseListDataStore) {
        self.dataStore = dataStore
        let section = CourseSectionViewModel()
        dataStore.courses.forEach {
            section.rows.append(CourseCellViewModel(course: $0))
        }
        view.reloadData(for: section)
    }
}
