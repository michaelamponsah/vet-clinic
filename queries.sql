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

SELECT id, name, escape_attempts FROM animals 
  WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

SELECT species, weight_kg AS max_weight FROM animals 
  WHERE species = 'digimon' 
  AND weight_kg = (SELECT MAX(weight_kg) FROM animals WHERE species = 'digimon');

SELECT species, weight_kg AS min_weight FROM animals
  WHERE species = 'digimon' 
  AND weight_kg = (SELECT MIN(weight_kg) FROM animals WHERE species = 'digimon');

SELECT species, weight_kg AS max_weight FROM animals 
  WHERE species = 'pokemon' 
  AND weight_kg = (SELECT MAX(weight_kg) FROM animals WHERE species = 'pokemon');

SELECT species, weight_kg AS min_weight FROM animals
  WHERE species = 'pokemon' 
  AND weight_kg = (SELECT MIN(weight_kg) FROM animals WHERE species = 'pokemon');

SELECT species, AVG(escape_attempts) AS avg_escapes FROM animals
  WHERE species = 'digimon'
  AND date_of_birth 
  BETWEEN '01/01/1990' AND '31/12/2000' 
  GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escapes FROM animals
  WHERE species = 'pokemon' 
  AND date_of_birth 
  BETWEEN '01/01/1990' AND '31/12/2000'
  GROUP BY species;

-- Animals that belong to Melody Pond;
SELECT animals.name AS animal_name, owners.fullname AS owner FROM animals
  JOIN owners  ON animals.owner_id = owners.id
  WHERE owners.fullname = 'Melody Pond';

-- Pokemon type animals
SELECT animals.name AS animal_name, species.name AS species FROM animals
  JOIN species ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';

-- All owners and their animals
SELECT owners.fullname AS owner, animals.name AS animal_name FROM animals
  RIGHT JOIN owners ON owners.id = animals.owner_id;

--Animals per species
SELECT species.name AS species, COUNT(animals.species_id) AS num FROM species
  JOIN animals ON animals.species_id = species.id
  GROUP BY animals.species_id, species.name;

-- All Digimon owned by Jennifer Orwell.
SELECT owners.fullname AS owner, animals.name, COUNT(animals.owner_id) AS digimon_count FROM owners 
  JOIN animals ON owners.id = animals.owner_id 
  WHERE owners.id = 2 AND animals.species_id = 2 
  GROUP BY owners.fullname, animals.owner_id, animals.name;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name AS no_escape_attempts, owners.fullname AS owner FROM animals 
  JOIN owners ON animals.owner_id =  owners.id 
  WHERE animals.owner_id = 5 AND animals.escape_attempts = 0 
  GROUP by owners.fullname, animals.name;

-- Who owns the most animals
SELECT  owners.fullname AS owner_name, COUNT(animals.owner_id) AS owner_id FROM animals 
  JOIN owners ON animals.owner_id = owners.id
  WHERE animals.owner_id = owners.id 
  GROUP BY owners.fullname, animals.owner_id 
  ORDER BY owner_id DESC LIMIT 1; 

-- Last animal seen by William Tatcher
SELECT animals.name AS animal_name, visits.date_of_visit FROM animals 
  JOIN visits ON animals.id = visits.animal_id 
  WHERE visits.vet_id = 1 GROUP BY animals.name, visits.date_of_visit 
  ORDER BY date_of_visit DESC LIMIT 1; 

-- How many diff animals did Stephanie see
SELECT vets.name as vet_name, COUNT(visits.animal_id) AS animal_count FROM visits
  JOIN vets ON visits.vet_id = vets.id 
  WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

-- All vets and specialities
SELECT vets.name AS vet_name, species.name AS specialization FROM vets 
  LEFT JOIN specialization ON vets.id = specialization.vet_id 
  LEFT JOIN species ON species.id = specialization.species_id;

-- All animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name AS vet_name, animals.name AS animal_name FROM vets 
  INNER JOIN visits ON vets.id = visits.vet_id 
  JOIN animals ON animals.id = visits.animal_id 
  WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit 
  BETWEEN '01/04/2020' AND '30/08/2020' 
  GROUP BY vet_name, animal_name;

-- Animal with most visits
SELECT animals.name, count(*) FROM animals
  JOIN visits ON visits.animal_id = animals.id
  GROUP BY animals.name
  ORDER BY count desc limit 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, visits.date_of_visit FROM animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vets ON visits.vet_id = vets.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visits.date_of_visit ASC lIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visit FROM animals
  JOIN visits ON animals.id = visits.animal_id
  JOIN vets ON visits.vet_id = vets.id
  ORDER BY visits.date_of_visit DESC lIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM vets 
  JOIN visits ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
  JOIN specialization ON vets.id = specialization.vet_id
  WHERE NOT specialization.species_id = animals.species_id;

  -- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name, species.name, count(species.name) from vets 
  JOIN visits On visits.vet_id = vets.id 
  JOIN animals ON visits.animal_id = animals.id 
  JOIN species ON animals.species_id = species.id 
  WHERE vets.name = 'Maisy Smith' 
  GROUP BY species.name, vets.name 
  ORDER BY count DESC lIMIT 1;