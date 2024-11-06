def paycheck(hours_of_work, price_per_hour):
    regular_hours = 40
    overtime_bonus = 1.5

    if hours_of_work <= regular_hours:
        return hours_of_work * price_per_hour

    regular_pay = regular_hours * price_per_hour
    overtime_hours = hours_of_work - regular_hours
    overtime_pay = overtime_hours * price_per_hour * overtime_bonus

    return regular_pay + overtime_pay


print("Abcd" < "Acdb")
check = paycheck(45, 40)

print(f"Paga juaj është: {check} $")