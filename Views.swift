//
//  Root2View.swift
//  TreeNavigation
//
//  Created by kursor on 06.03.2025.
//
import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        StackView(childStack: viewModel.childStack) { child in
            switch child {
            case .home(let homeViewModel):
                HomeView(viewModel: homeViewModel)
            case .pokemonFlow(let pokemonFlowViewModel):
                PokemonFlowView(viewModel: pokemonFlowViewModel)
            case .search(let searchViewModel):
                SearchView(viewModel: searchViewModel)
            case .settings(let settingsViewModel):
                SettingsView(viewModel: settingsViewModel)
            }
        }
    }
}

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            Text("Home")
            Button("Next Screen", action: { viewModel.onNextClick() })
        }
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        VStack {
            Text("Settings")
            Button("Next Screen", action: { viewModel.onNextClick() })
        }
    }
}

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    var body: some View {
        VStack {
            Text("Search")
            Button("Next Screen", action: { viewModel.onNextClick() })
        }
    }
}

struct PokemonFlowView: View {
    @ObservedObject var viewModel: PokemonFlowViewModel
    
    var body: some View {
        StackView(childStack: viewModel.childStack) { child in
            let _ = print(child)
            switch child {
            case .details(let detailsViewModel):
                PokemonDetailsView(viewModel: detailsViewModel)
            case .list(let listViewModel):
                PokemonListView(viewModel: listViewModel)
            }
        }
    }
}

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonListViewModel
    
    var body: some View {
        VStack {
            Text("Pokemon List")
            Button("Next Screen", action: { viewModel.onNextClick() })
        }
    }
}

struct PokemonDetailsView: View {
    @ObservedObject var viewModel: PokemonDetailsViewModel

    var body: some View {
        let _ = print("PokemonDetailsView")
        VStack {
            Text("Pokemon Details")
            Button("Show Bottom Sheet", action: { viewModel.onShowVote() })
        }
        .childSlotSheet(childSlot: viewModel.childSlot) { child in
            PokemonVoteView(viewModel: child)
        }
    }
}

struct PokemonVoteView: View {
    @ObservedObject var viewModel: PokemonVoteViewModel
    var body: some View {
        VStack {
            Text("Pokemon Vote")
        }
    }
}
