//
//  PlayerFeature.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 12.10.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct PlayerFeature {
    @ObservableState
    struct State: Equatable {
        var isPlay: Bool = false
        var isLoading: Bool = true
    }
    
    enum Action {
        case checkURL(URL)
        case responseCheckURL(Result<HTTPURLResponse, Error>)
        case play
        case pause
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .play:
                MusicPlayer.shared.play()
                state.isPlay = true
                return .none
            case .pause:
                MusicPlayer.shared.stop()
                state.isPlay = false
                return .none
            case let .checkURL(url):
                return .run { send in
                        let result = await checkisValidURL(url: url)
                        await send(.responseCheckURL(result))
                }
            case .responseCheckURL(let result):
                state.isLoading = false
                switch result {
                case .success(let urlResponse):
                    MusicPlayer.shared.activateAVAudionSession()
                    MusicPlayer.shared.changeItem(url: urlResponse.url!)
                    MusicPlayer.shared.play()
                    state.isPlay = true
                 case .failure(let error):
                    print("Error is happening: \(error.localizedDescription)")
                }
                return .none
            }
        }
    }
    
    private func checkisValidURL(url: URL) async  -> Result<HTTPURLResponse, Error> {
        let urlSession = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        guard let (_, response) = try? await urlSession.data(for: request) else {
            // TODO: Need to verify this error code is good or not
            return .failure(URLError(URLError.badURL))
        }
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    return .success(httpResponse)
                }
            } else {
                // TODO: Need to verify this error code is good or not
                return .failure(URLError(URLError.badURL))
            }
        // TODO: Need to verify this error code is good or not
        return .failure(URLError(URLError.badURL))
    }
    
    
}
