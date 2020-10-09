enum SendMessage {
    case text(TextSendMessage)
    case image(ImageSendMessage)    
}

extension SendMessage: Encodable {
    func encode(to encoder: Encoder) throws {
        var singleValueContainer = encoder.singleValueContainer()
        switch self {
        case .text(let textSendMessage):
            try singleValueContainer.encode(textSendMessage)
        case .image(let imageSendMessage):
            try singleValueContainer.encode(imageSendMessage)
        }
    }
}
