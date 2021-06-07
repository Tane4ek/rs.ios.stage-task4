import Foundation

final class CallStation {
    var usersArray: [User] = []
    var callsArray: [Call] = []
}

extension CallStation: Station {
    func users() -> [User] {
        return usersArray
    }
    
    func add(user: User) {
        if (!usersArray.contains(user)) {
            usersArray.append(user)
        }
    }
    
    func remove(user: User) {

    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
            case .start(let incomingUser, let outgoingUser):
                let call = Call(id: UUID(), incomingUser: incomingUser, outgoingUser: outgoingUser, status: .calling)
                callsArray.append(call)
                return call.id
        case .answer(from: let from):
            for i in 0..<callsArray.count {
                if callsArray[i].outgoingUser == from {
                    let call = Call(id: callsArray[i].id, incomingUser: callsArray[i].incomingUser, outgoingUser: callsArray[i].outgoingUser, status: .talk)
                    callsArray[i] = call
                    return callsArray[i].id
                }
            }
            return nil
        case .end(from: let from):
            for i in 0..<callsArray.count {
                if callsArray[i].outgoingUser == from || callsArray[i].incomingUser == from {
                    if (callsArray[i].status == .calling) {
                        let call = Call(id: callsArray[i].id, incomingUser: callsArray[i].incomingUser, outgoingUser: callsArray[i].outgoingUser, status: .ended(reason: .cancel))
                        callsArray[i] = call
                    }
                    else {
                        let call = Call(id: callsArray[i].id, incomingUser: callsArray[i].incomingUser, outgoingUser: callsArray[i].outgoingUser, status: .ended(reason: .end))
                        callsArray[i] = call
                    }
                    return callsArray[i].id
                }
            }
            return nil
        }
    }
    
    func calls() -> [Call] {
        return callsArray
    }
    
    func calls(user: User) -> [Call] {
        var calls: [Call] = []
        for i in 0..<callsArray.count {
            if (callsArray[i].outgoingUser == user || callsArray[i].incomingUser == user) {
                calls.append(callsArray[i])
            }
        }
        return calls
    }
    
    func call(id: CallID) -> Call? {
        nil
    }
    
    func currentCall(user: User) -> Call? {
        for i in 0..<callsArray.count {
            if (callsArray[i].outgoingUser == user || callsArray[i].incomingUser == user) && ((callsArray[i].status == .talk) || (callsArray[i].status == .calling)) {
                return callsArray[i]
            }
        }
        return nil
    }
}
