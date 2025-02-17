
## Choose your language version
- [Polski](#habit-tracker-pol)
- [English](#habit-tracker-en)

---
# Habit Tracker (Polski) <a name="habit-tracker-pol"></a>

Aplikacja umożliwia śledzenie nawyków użytkownika oraz motywowanie do konsekwentnego działania. Główne funkcjonalności obejmują tworzenie, edytowanie, usuwanie nawyków, personalizację nawyków, przegląd nawyków oraz przypomnienia o ich realizacji.

## Główne funkcje
- **Tworzenie, edytowanie i usuwanie nawyków** – Możliwość dostosowania nawyków do własnych potrzeb.
- **Personalizacja nawyków** – Wybór typu (codziennie, tygodniowo, miesięcznie), częstotliwości, opisu i wyglądu.
- **Przegląd nawyków** – Wyświetlanie listy nawyków według różnych kryteriów, takich jak status wykonania.
- **Powiadomienia** – Wysyłanie przypomnień o realizacji nawyków.
- **Automatyczne resetowanie statusów** – Codzienne, tygodniowe lub miesięczne resetowanie statusów nawyków.

## Integracje
- **Firebase** – Użycie Firestore do przechowywania danych oraz Firebase Auth do uwierzytelniania użytkowników.
- **Android Alarm Manager** – Automatyczne resetowanie statusów nawyków.
- **Flutter Local Notifications** – Powiadomienia o realizacji nawyków zaplanowane na godziny 12:00 i 20:00.

## Instrukcja i Logowanie
- **Rejestracja i logowanie** – Możliwość założenia konta z adresem email lub skorzystania z konta testowego (email: abc@gmail.com, hasło: 123456).
- **Edycja nawyków** – Użytkownik może edytować lub usunąć nawyki, zmieniając ich status na "wykonany" lub "niewykonany".
- **Menu** – W górnym menu dostępne opcje:
  1. Zarządzanie kontem: wylogowanie, usunięcie konta.
  2. Przegląd nawyków na dany dzień, ukończonych nawyków oraz dodawanie nowych.
  3. Przegląd pełnej listy wszystkich nawyków.
  4. Informacje o aplikacji.

# Wybrane ekrany aplikacji

## Ekran rejestracji
<p align="center">
<img src="https://private-user-images.githubusercontent.com/160714456/413890054-55c8a40b-074a-40f7-80e9-eb8d55b91642.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzk4MDEyOTksIm5iZiI6MTczOTgwMDk5OSwicGF0aCI6Ii8xNjA3MTQ0NTYvNDEzODkwMDU0LTU1YzhhNDBiLTA3NGEtNDBmNy04MGU5LWViOGQ1NWI5MTY0Mi5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIxN1QxNDAzMTlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00NTVlYzY4NDcwOTNmMDRiMDNhOTgzN2VmYjljZTc0MjhhN2Y2NGE4Zjc5YzJhNTQzZTQ1NGQwNmJlZTVhYjYyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.PxupwuZDXivqiecPXWZSU6v912dQwxx6H6bm09U8jvg" width="300"/>
</p>

## Ekran główny
<p align="center">
<img src="https://private-user-images.githubusercontent.com/160714456/413890046-3d44373f-5d82-4516-8c35-9b1f8dec8c86.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzk4MDEyOTksIm5iZiI6MTczOTgwMDk5OSwicGF0aCI6Ii8xNjA3MTQ0NTYvNDEzODkwMDQ2LTNkNDQzNzNmLTVkODItNDUxNi04YzM1LTliMWY4ZGVjOGM4Ni5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIxN1QxNDAzMTlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1hMDhmYjU5ZWRmNGM3NGRlOTBlNjVmZjRjZDFhOTdiNDIzZGVkYjliMmRjMTY5ZTljZGQ3YmNlYWUxOGY1YzE2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.FBGRZTyQnt0cJYMR-YhZ5p6t3QdpkOYR8WrHM2Tjk74" width="300"/>
</p>

## Ekran z menu bocznym
<p align="center">
<img src="https://private-user-images.githubusercontent.com/160714456/413890015-ddebb88b-615c-4ad8-aac7-45eb65fe69c3.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzk4MDE1NjIsIm5iZiI6MTczOTgwMTI2MiwicGF0aCI6Ii8xNjA3MTQ0NTYvNDEzODkwMDE1LWRkZWJiODhiLTYxNWMtNGFkOC1hYWM3LTQ1ZWI2NWZlNjljMy5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIxN1QxNDA3NDJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0wMThlMzQzZDk3MWRmOWJjNGY4NDg5ZDliODQ4ZGY2NjVkNTAzNTkxZGVmZWYyMmU3ZThhZjc1MTNiZDI0MDE2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.KVF82wVVAKrlHMDqRZFIDK7-vl1J3zjOYdtwLvG4KTI" width="300"/>
</p>

## Ekran dodawania nowego nawyku
<p align="center">
<img src="https://private-user-images.githubusercontent.com/160714456/413890006-1435f72f-34f5-4b3b-89b0-5c011bea369d.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzk4MDEyOTksIm5iZiI6MTczOTgwMDk5OSwicGF0aCI6Ii8xNjA3MTQ0NTYvNDEzODkwMDA2LTE0MzVmNzJmLTM0ZjUtNGIzYi04OWIwLTVjMDExYmVhMzY5ZC5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIxN1QxNDAzMTlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xZDVhMmRkN2E3OWFhNDNhODJiNzgyYjQ1ZjcyNGJjNGJhNzA3M2RmMzZlZDRiZmFmZGE3M2M2YTRmYzkzYjc5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.lr2X4H9J7gkkbM1BHEDJsmBPPoPs9Z3VLyR_5vTUAJo" width="300"/>
</p>

# Habit Tracker (English) <a name="habit-tracker-en"></a>

The app allows users to track their habits and motivates them to take consistent actions. The main features include creating, editing, and deleting habits, personalizing habits, reviewing habits, and setting reminders for their execution.

## Main Features
- **Create, Edit, and Delete Habits** – Customize habits according to personal needs.
- **Personalize Habits** – Choose the type (daily, weekly, monthly), frequency, description, and appearance.
- **Habit Review** – Display a list of habits according to various criteria, such as completion status.
- **Notifications** – Send reminders about habit completion.
- **Automatic Status Reset** – Daily, weekly, or monthly automatic reset of habit statuses.

## Integrations
- **Firebase** – Use Firestore for data storage and Firebase Auth for user authentication.
- **Android Alarm Manager** – Automatic reset of habit statuses.
- **Flutter Local Notifications** – Notifications about habit completion scheduled for 12:00 PM and 8:00 PM.

## Instructions and Login
- **Registration and Login** – Users can create an account using an email address or log in with a test account (email: abc@gmail.com, password: 123456).
- **Editing Habits** – Users can edit or delete habits by changing their status to "completed" or "not completed."
- **Menu** – The top menu includes options:
  1. Account Management: log out, delete account.
  2. Review habits for the day, completed habits and add new habits.
  3. Review the full list of all habits.
  4. App Information.

# Selected App Screens
## Registration Screen
<p align="center">
  <img src="https://private-user-images.githubusercontent.com/160714456/413890054-55c8a40b-074a-40f7-80e9-eb8d55b91642.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzk4MDEyOTksIm5iZiI6MTczOTgwMDk5OSwicGF0aCI6Ii8xNjA3MTQ0NTYvNDEzODkwMDU0LTU1YzhhNDBiLTA3NGEtNDBmNy04MGU5LWViOGQ1NWI5MTY0Mi5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIxN1QxNDAzMTlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00NTVlYzY4NDcwOTNmMDRiMDNhOTgzN2VmYjljZTc0MjhhN2Y2NGE4Zjc5YzJhNTQzZTQ1NGQwNmJlZTVhYjYyJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.PxupwuZDXivqiecPXWZSU6v912dQwxx6H6bm09U8jvg" width="300"/>
</p>

## Main Screen
<p align="center">
  <img src="https://private-user-images.githubusercontent.com/160714456/413890046-3d44373f-5d82-4516-8c35-9b1f8dec8c86.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzk4MDEyOTksIm5iZiI6MTczOTgwMDk5OSwicGF0aCI6Ii8xNjA3MTQ0NTYvNDEzODkwMDQ2LTNkNDQzNzNmLTVkODItNDUxNi04YzM1LTliMWY4ZGVjOGM4Ni5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIxN1QxNDAzMTlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT1hMDhmYjU5ZWRmNGM3NGRlOTBlNjVmZjRjZDFhOTdiNDIzZGVkYjliMmRjMTY5ZTljZGQ3YmNlYWUxOGY1YzE2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.FBGRZTyQnt0cJYMR-YhZ5p6t3QdpkOYR8WrHM2Tjk74" width="300"/>
</p>

## Screen with Side Menu
<p align="center">
<img src="https://private-user-images.githubusercontent.com/160714456/413890015-ddebb88b-615c-4ad8-aac7-45eb65fe69c3.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzk4MDE1NjIsIm5iZiI6MTczOTgwMTI2MiwicGF0aCI6Ii8xNjA3MTQ0NTYvNDEzODkwMDE1LWRkZWJiODhiLTYxNWMtNGFkOC1hYWM3LTQ1ZWI2NWZlNjljMy5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIxN1QxNDA3NDJaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0wMThlMzQzZDk3MWRmOWJjNGY4NDg5ZDliODQ4ZGY2NjVkNTAzNTkxZGVmZWYyMmU3ZThhZjc1MTNiZDI0MDE2JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.KVF82wVVAKrlHMDqRZFIDK7-vl1J3zjOYdtwLvG4KTI" width="300"/>
</p>

## New Habit Screen
<p align="center">
<img src="https://private-user-images.githubusercontent.com/160714456/413890006-1435f72f-34f5-4b3b-89b0-5c011bea369d.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3Mzk4MDEyOTksIm5iZiI6MTczOTgwMDk5OSwicGF0aCI6Ii8xNjA3MTQ0NTYvNDEzODkwMDA2LTE0MzVmNzJmLTM0ZjUtNGIzYi04OWIwLTVjMDExYmVhMzY5ZC5qcGc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwMjE3JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDIxN1QxNDAzMTlaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xZDVhMmRkN2E3OWFhNDNhODJiNzgyYjQ1ZjcyNGJjNGJhNzA3M2RmMzZlZDRiZmFmZGE3M2M2YTRmYzkzYjc5JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.lr2X4H9J7gkkbM1BHEDJsmBPPoPs9Z3VLyR_5vTUAJo" width="300"/>
</p>



