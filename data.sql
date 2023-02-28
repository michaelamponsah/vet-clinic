/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '03/02/2020', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '15/11/2018', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '07/01/2021', 1, false,  15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '12/05/2017', 5, true,  11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '9/02/2022', 0, false,  11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '15/11/2021', 2, true,  5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '02/04/1993', 3, true,  12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '12/06/2005', 1, true,  45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '7/06/2005', 7, true,  20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '13/10/1998', 3, true,  17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '14/05/2022', 4, true,  22);


INSERT INTO owners VALUES ('Sam Smith', 34);
INSERT INTO owners VALUES ('Jennifer Orwell', 19);
INSERT INTO owners VALUES ('Bob', 45);
INSERT INTO owners VALUES ('Melody Pond', 77);
INSERT INTO owners VALUES ('Dean Winchester', 14);
INSERT INTO owners VALUES ('Jodie Whittaker', 38);

INSERT INTO species VALUES('Pokemon');
INSERT INTO species VALUES('Digimon');

UPDATE animalS SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animalS SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animalS SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animalS SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animalS SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';
UPDATE animalS SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animalS SET species_id = 1 WHERE species_id IS NULL;

-- Vets
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '23/04/2000');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '17/01/2019');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '04/05/1981');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '08/06/2008');

-- Specialization 
INSERT INTO specialization (species_id, vet_id) VALUES (1, 1);
INSERT INTO specialization (species_id, vet_id) VALUES (1, 3);
INSERT INTO specialization (species_id, vet_id) VALUES (2, 3);
INSERT INTO specialization (species_id, vet_id) VALUES (2, 4);

-- Visits
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (12, 1, '24/05/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (12, 3, '22/07/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (3, 4, '02/02/2021');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (8, 2, '05/01/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (8, 2, '08/03/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (8, 2, '14/05/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (4, 3, '04/05/2021');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (11, 4, '24/02/2021');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (5, 2, '21/12/2019');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (5, 1, '10/08/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (5, 2, '07/04/2021');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (9, 3, '20/09/2019');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (6, 4, '03/10/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (6, 4, '04/11/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (7, 2, '24/01/2019');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (7, 2, '15/05/2019');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (7, 2, '27/02/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (7, 2, '3/08/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (10, 3, '24/05/2020');
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (10, 1, '11/01/2021');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (fullname, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';