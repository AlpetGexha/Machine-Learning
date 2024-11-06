import random


def gameplay():
    secret_number = random.randint(1, 100)
    attempts = 0
    max_attempts = 5

    print("Mirësevini në lojën 'Gjej numrin e fshehtë'!")
    print(f"Ju keni {max_attempts} tentativa për të gjetur numrin nga 1 deri në 100.")

    while attempts < max_attempts:
        guess = int(input("Fut një numër: "))
        attempts += 1

        if attempts == max_attempts and guess != secret_number:
            print(f"Ke humbur! Numri sekret ishte {secret_number}.")
            break

        if guess == secret_number:
            print(f"Urime! E gjete numrin e fshehtë ({secret_number}) që në tentativën e {attempts}-të!")
            break
        elif guess < secret_number:
            print(f"Numri është më i madh se {guess}.")
        else:
            print(f"Numri është më i vogël se {guess}.")


while True:
    gameplay()
    play_again = input(
        "Dëshironi të luani përsëri? Shtypni 'po' për të luajtur sërish ose çdo gjë tjetër për të dalë: ").lower()

    if play_again != 'po':
        print("Faleminderit që luajtët!")
        break
