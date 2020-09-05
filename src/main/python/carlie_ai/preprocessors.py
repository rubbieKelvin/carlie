from chatterbot.conversation import Statement

def lower(statement:Statement) -> Statement:
    statement.text = statement.text.lower()
    return statement