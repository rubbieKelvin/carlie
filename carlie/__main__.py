from .core import Carlie

bot = Carlie()

while True:
    try:
        msg = input()
        response = bot.get_response(msg)
        print(bot.name.lower()+":", response)
    except (SystemExit, KeyboardInterrupt, EOFError):
        print()
        break