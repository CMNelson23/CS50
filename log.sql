-- Keep a log of any SQL queries you execute as you solve the mystery.

--Finding crime scene description
SELECT description
FROM crime_scene_reports
WHERE month = 7 AND day = 28
AND street = 'Humphrey Street';
-- Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
--Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.

-- Witness Interviews
SELECT * FROM interviews
WHERE transcript LIKE '%bakery%';

-- Witness Ruth claims she saw theif get into car in parking. Suggests reviewing bakery parking lot footage.
-- Witness Eugene recognized theif from ATM on Leggett Street, check ATM security.
-- Witness Raymond overheard phone call, where theif is planning to fly (first flight out of town), accomplice purchased tickets.

-- Following Ruths tip
SELECT * FROM bakery_security_logs WHERE month = 7 and day = 28 and hour = 10 AND minute BETWEEN 15 and 25;
--Checking against license plates
SELECT p.name, bsl.activity, bsl.license_plate, bsl.year, bsl.month, bsl.day, bsl.hour, bsl.minute
FROM bakery_security_logs bsl
JOIN people p ON p.license_plate = bsl.license_plate
WHERE bsl.year = 2023 AND bsl.month = 7 AND bsl.day = 28 AND bsl.hour = 10 AND bsl.minute BETWEEN 15 AND 25;

-- Flowing Eugenes tip
SELECT * FROM atm_transactions
WHERE atm_location = 'Leggett Street'
AND month = 7 AND day = 28;
-- Adding name to ATM transactions
SELECT a.*, p.name
FROM atm_transactions a
JOIN bank_accounts b on a.account_number = b.account_number
JOIN people p ON b.person_id = p.id
WHERE a.atm_location = 'Leggett Street' AND a.month = 7 AND a.day = 28 AND a.transaction_type = 'withdraw';
-- Bruce, Diana, Iman, and Luca appear both bakery security logs and atm logs

-- Following Raymonds tip
SELECT *
FROM phone_calls
WHERE month = 7 AND day = 28 AND duration < 60;
-- add callers to list
SELECT p.name, pc.caller, pc.receiver, pc.year,pc.month, pc.day, pc.duration
FROM phone_calls pc
JOIN people p ON pc.caller = p.phone_number
WHERE pc.year = 2023 AND pc.month = 7 AND pc.day = 28 AND duration < 60;

--combine/cross reference info gathered from witness tips
SELECT p.name
FROM bakery_security_logs bsl
JOIN people p ON p.license_plate = bsl.license_plate
JOIN bank_accounts ba ON ba.person_id = p.id
JOIN atm_transactions at ON at.account_number = ba.account_number
JOIN phone_calls pc ON pc.caller = p.phone_number
WHERE bsl.month = 7 AND bsl.day = 28 AND bsl.year = 2023 AND bsl.hour = 10 AND bsl.minute between 15 AND 25
AND at.atm_location = 'Leggett Street' AND at.year = 2023 AND at.month = 7 AND at.day = 28 AND at.transaction_type = 'withdraw'
AND pc.year = 2023 AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;

-- Bruce and Diana are the only remaining suspects, narrow down based on passenger list

-- find fiftyville origin airport id
SELECT * FROM airports;
-- CSF id = 8, find flights out
SELECT f.*, origin.full_name AS origin_airport_id, destination.full_name AS destination_airport
FROM flights f
JOIN airports origin ON f.origin_airport_id = origin.id
JOIN airports destination ON f.destination_airport_id = destination.id
WHERE origin.id = 8 AND f.year = 2023 and f.month = 7 AND f.day = 29
ORDER BY f.hour, f.minute;
-- First flight out is to LaGuardia (id = 36), checking passenger list for remaining suspect
SELECT p.name
FROM people p
JOIN passengers ps ON p.passport_number = ps.passport_number
WHERE ps.flight_id = 36
AND p.name IN ('Bruce', 'Diana');
-- Bruce is confirmed, finding accomplice
SELECT p2.name AS receiver
FROM phone_calls pc
JOIN people p1 ON pc.caller = p1.phone_number
JOIN people p2 on pc.receiver = p2.phone_number
WHERE p1.name = 'Bruce' AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;
--Robin confirmed accomplice
