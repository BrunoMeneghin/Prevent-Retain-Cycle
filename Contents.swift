

/*:
 # Capture list to prevent Retain Cycle
   CLOSURE RETAIN CYCLE
 */
//: WEAK

import UIKit

class SportEvent {
    var sport: (() -> ())?
    var event: String = "Soccer"
    
    init() {
        sport = { [weak self] in
            guard let sport = self else { return }
            print("\(sport.event) - Manchester City Vs. Manchester United")
        }
    }
    
    deinit {
        print("Soccer has been deallocated")
    }
}

var sportEvent: SportEvent? = SportEvent()
sportEvent?.sport?()
sportEvent = nil // When there is no longer an object reference to the abstract class, when the object is DEALLOC, the closusure reference will have a reference to an object that was DEALLOCATED. This is dangerous and a CRASH will happen!!

//: UNOWNED

// INDEPENDENT CLASS

class Owner {
    var creditCard: CreditCard?
    deinit {
        print("Owner has been deallocated")
    }
}

// DEPENDENT CLASS

class CreditCard {
    unowned let owner: Owner?
    
    init(owner: Owner) {
        self.owner = owner
    }
}

// CREATE INSTANCES

var user: Owner? = Owner()
var card = CreditCard(owner: user!)

user?.creditCard = card
user = nil // remove reference and dealloc
// card.owner // CRASH -> RETAIN CYCLE
