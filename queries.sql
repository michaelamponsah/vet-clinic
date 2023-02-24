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

-- Animals that belong to Melody Pond;
SELECT animals.name AS animal_name, owners.fullname AS owner FROM animals JOIN owners  ON animals.owner_id = owners.id WHERE owners.fullname = 'Melody Pond';

-- Pokemon type animals
SELECT animals.name AS animal_name, species.name AS species FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- All owners and their animals
SELECT owners.fullname AS owner, animals.name AS animal_name FROM animals RIGHT JOIN owners ON owners.id = animals.owner_id;

--Animals per species
SELECT species.name AS species, COUNT(animals.species_id) AS num FROM species  JOIN animals ON animals.species_id = species.id GROUP BY animals.species_id, species.name;

-- All Digimon owned by Jennifer Orwell.
SELECT owners.fullname AS owner, animals.name, COUNT(animals.owner_id) AS digimon_count FROM owners JOIN animals ON owners.id = animals.owner_id WHERE owners.id = 2 AND animals.species_id = 2 GROUP BY owners.fullname, animals.owner_id, animals.name;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name AS no_escape_attempts, owners.fullname AS owner FROM animals JOIN owners ON animals.owner_id =  owners.id WHERE animals.owner_id = 5 AND animals.escape_attempts = 0 GROUP by owners.fullname, animals.name;

-- Who owns the most animals
SELECT  owners.fullname AS owner_name, COUNT(animals.owner_id) AS owner_id FROM animals JOIN owners ON animals.owner_id = owners.id WHERE animals.owner_id = owners.id GROUP BY owners.fullname, animals.owner_id ORDER BY owner_id DESC LIMIT 1; 

