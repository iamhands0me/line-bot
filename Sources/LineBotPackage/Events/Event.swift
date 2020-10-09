public enum Event {
    case message(MessageEvent)
    case follow(FollowEvent)
    
    enum type: String, Decodable {
        case message = "message",
             follow = "follow"
    }
}

extension Event: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Event.type.self, forKey: .type)
        switch type {
        case .message:
            let singleValueContainer = try decoder.singleValueContainer()
            let messageEvent = try singleValueContainer.decode(MessageEvent.self)
            self = .message(messageEvent)
        case .follow:
            let singleValueContainer = try decoder.singleValueContainer()
            let followEvent = try singleValueContainer.decode(FollowEvent.self)
            self = .follow(followEvent)
        }
    }
}
