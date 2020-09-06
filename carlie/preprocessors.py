from chatterbot.conversation import Statement

def attach_intent(statement:Statement) -> Statement:
    setattr(statement, "intent", "")
    return statement