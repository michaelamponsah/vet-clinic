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
