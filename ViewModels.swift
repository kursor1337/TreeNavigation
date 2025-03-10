//
//  Screen.swift
//  TreeNavigation
//
//  Created by kursor on 06.03.2025.
//

import SwiftUI

class RootViewModel : ObservableObject {
    
    @Published var childStack: ChildStack<Child>
    
    init() {
        childStack = ChildStack(
            items: [.home(viewModel: HomeViewModel(onNextClick: {  }))]
        )
        
        let onNextClickHandler: () -> Void = { [weak self] in
            self?.onNextClick()
        }
        
        childStack = ChildStack(
            items: [.home(viewModel: HomeViewModel(onNextClick: onNextClickHandler))]
        )
    }
    
    func onNextClick() {
        switch childStack.active {
        case .home:
            print("navigating from RootViewModel.Child.home to RootViewModel.Child.settings")
            childStack = childStack.push(
                child: .settings(viewModel: SettingsViewModel(onNextClick: onNextClick))
            )
        case .settings:
            print("navigating from RootViewModel.Child.settings to RootViewModel.Child.search")
            childStack = childStack.push(
                child: .search(viewModel: SearchViewModel(onNextClick: onNextClick))
            )
        case .search:
            print("navigating from RootViewModel.Child.search to RootViewModel.Child.pokemonFlow")
            childStack = childStack.push(
                child: .pokemonFlow(viewModel: PokemonFlowViewModel())
            )
        case .pokemonFlow:
            break
        }
    }
    
    enum Child : Hashable {
        case settings(viewModel: SettingsViewModel)
        case home(viewModel: HomeViewModel)
        case search(viewModel: SearchViewModel)
        case pokemonFlow(viewModel: PokemonFlowViewModel)
        
        static func == (lhs: RootViewModel.Child, rhs: RootViewModel.Child) -> Bool {
            switch (lhs, rhs) {
                case (.settings, .settings), (.home, .home), (.search, .search), (.pokemonFlow, .pokemonFlow):
                return true
            default:
                return false
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .settings:
                hasher.combine("settings")
            case .home:
                hasher.combine("home")
            case .search:
                hasher.combine("search")
            case .pokemonFlow:
                hasher.combine("pokemonFlow")
            }
        }
    }
}

class HomeViewModel : ObservableObject {
    let onNextClick: () -> Void
    init(onNextClick: @escaping () -> Void) {
        self.onNextClick = onNextClick
    }
}

class SettingsViewModel : ObservableObject {
    let onNextClick: () -> Void
    init(onNextClick: @escaping () -> Void) {
        self.onNextClick = onNextClick
    }
}



class SearchViewModel : ObservableObject {
    let onNextClick: () -> Void
    init(onNextClick: @escaping () -> Void) {
        self.onNextClick = onNextClick
    }
}

class PokemonFlowViewModel : ObservableObject {
    @Published var childStack: ChildStack<Child>
                
    init() {
        self.childStack = ChildStack(items: [.list(viewModel: PokemonListViewModel(onNextClick: {  }))])
        
        let onNextClickHandler: () -> Void = { [weak self] in
            self?.onNextClick()
        }
        
        self.childStack = ChildStack(items: [.list(viewModel: PokemonListViewModel(onNextClick: onNextClickHandler))])
    }
    
    func onNextClick() {
        switch childStack.active {
        case .list:
            print("navigating from PokemonFlowViewModel.Child.list to PokemonFlowViewModel.Child.details")
            childStack = childStack.push(
                child: .details(viewModel: PokemonDetailsViewModel())
            )
        case .details:
            break
        }
    }
                
    enum Child : Hashable {
        
        case list(viewModel: PokemonListViewModel)
        case details(viewModel: PokemonDetailsViewModel)
        
        static func == (lhs: PokemonFlowViewModel.Child, rhs: PokemonFlowViewModel.Child) -> Bool {
            switch (lhs, rhs) {
            case (.list, .list), (.details, .details):
                return true
            default:
                return false
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .list:
                hasher.combine("list")
            case .details:
                hasher.combine("details")
            }
        }
    }
}

class PokemonListViewModel : ObservableObject {
    let onNextClick: () -> Void
    init(onNextClick: @escaping () -> Void) {
        self.onNextClick = onNextClick
    }
}

class PokemonDetailsViewModel : ObservableObject {
    
    @Published var childSlot: ChildSlot<PokemonVoteViewModel>
    
    init() {
        self.childSlot = ChildSlot(item: nil)
    }
    
    func onShowVote() {
        print("Showing PokemonVote bottomsheet")
        childSlot = childSlot.show(item: PokemonVoteViewModel())
    }
}

class PokemonVoteViewModel : ObservableObject, Identifiable {
    
}

struct ChildStack<T : Hashable> {
    let items: [T]
    var active: T { get { items.last! } }
}

struct ChildSlot<T : Identifiable> {
    let item: T?
}

extension ChildStack {
    
    func push(child: T) -> ChildStack {
        return ChildStack(items: items + [child])
    }
    
    func pop() -> ChildStack {
        return ChildStack(items: Array(items.dropLast()))
    }
}

extension ChildSlot {
    
    func show(item: T) -> ChildSlot {
        return ChildSlot(item: item)
    }
    
    func hide() -> ChildSlot {
        return ChildSlot(item: nil)
    }
}
