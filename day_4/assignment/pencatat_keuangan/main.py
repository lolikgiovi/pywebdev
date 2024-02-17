pemasukan = []
pengeluaran = []

while True:
    print("\nPilih menu:")
    print("1. Catat pemasukan baru")
    print("2. Catat pengeluaran baru")
    print("3. Total pemasukan")
    print("4. Total pengeluaran")
    print("5. Saldo (Sum all)")
    print("6. Exit")

    choice = input("\nPilih menu: ")

    if choice == "1":
        nominal = int(input("Pemasukan baru (rupiah): "))
        pemasukan.append(nominal)
        print(f"Pemasukan baru senilai Rp {nominal} berhasil tercatat")

    elif choice == "2":
        nominal = int(input("Pengeluaran baru (rupiah): "))
        pengeluaran.append(nominal)
        print(f"Pengeluaran baru senilai Rp {nominal} berhasil tercatat")

    elif choice == "3":
        print("List uang masuk:", pemasukan)
        print("Total uang masuk:", sum(pemasukan))

    elif choice == "4":
        print("List uang keluar:", pengeluaran)
        print("Total uang keluar:", sum(pengeluaran))

    elif choice == "5":
        print("Saldo (Uang masuk - Uang keluar):", sum(pemasukan) - sum(pengeluaran))

    elif choice == "6":
        print("Keluar dari program. Dadah!")
        break

    else:
        print("Menu yang anda pilih tidak tersedia. Silakan pilih menu yang disediakan")
