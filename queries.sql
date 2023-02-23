/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '31/12/2016' AND '01/01/2019';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROm animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Project II
ALTER TABLE animals ADD species VARCHAR(250);

BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK TRANSACTION;
SELECT * FROM animals;

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

SELECT * FROM animals;
ROLLBACK TRANSACTION;
SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '01/01/2022';
SAVEPOINT deleteAboveJan;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO deleteAboveJan;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

SELECT COUNT(id) FROM animals;
SELECT COUNT(id) FROM animals WHERE escape_attempts = 1;
SELECT AVG(weight_kg) FROM animals;

SELECT id, name, escape_attempts FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
SELECT species, weight_kg AS max_weight FROM animals WHERE species = 'digimon' AND weight_kg = (SELECT MAX(weight_kg) FROM animals WHERE species = 'digimon');
SELECT species, weight_kg AS min_weight FROM animals WHERE species = 'digimon' AND weight_kg = (SELECT MIN(weight_kg) FROM animals WHERE species = 'digimon');

SELECT species, weight_kg AS max_weight FROM animals WHERE species = 'pokemon' AND weight_kg = (SELECT MAX(weight_kg) FROM animals WHERE species = 'pokemon');
SELECT species, weight_kg AS min_weight FROM animals WHERE species = 'pokemon' AND weight_kg = (SELECT MIN(weight_kg) FROM animals WHERE species = 'pokemon');

SELECT species, AVG(escape_attempts) AS avg_escapes FROM animals WHERE species = 'digimon' AND date_of_birth BETWEEN '01/01/1990' AND '31/12/2000' GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escapes FROM animals WHERE species = 'pokemon' AND date_of_birth BETWEEN '01/01/1990' AND '31/12/2000' GROUP BY species;